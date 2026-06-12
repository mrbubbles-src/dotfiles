#!/bin/zsh
set -u
set -o pipefail

SOURCE="$HOME/dev"
LOG_PREFIX="$HOME/.backup-scripts/log"
STATE_DIR="$HOME/.backup-scripts/state"
HASH_ICLOUD="$STATE_DIR/last-dev-hash-icloud.txt"
HASH_EXTERNAL="$STATE_DIR/last-dev-hash-external.txt"
LOCK_DIR="$STATE_DIR/backup-dev.lock"
EXCLUDES="$HOME/.dev-backup-exclude"

ICLOUD_ROOT="$HOME/Library/Mobile Documents/com~apple~CloudDocs/dev-backups"
EXT_VOLUME="/Volumes/Data"
EXT_ROOT="$EXT_VOLUME/dev-backups"

DATE="$(date +"%Y-%m-%d_%H-%M")"
MAX_KB=102400000
RETENTION_DAYS=6

mkdir -p "$LOG_PREFIX" "$STATE_DIR"

log() {
  printf '[%s] %s\n' "$(date +"%Y-%m-%d %H:%M:%S")" "$*"
}

fail() {
  log "[ERROR] $*"
  exit 1
}

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  fail "Backup läuft bereits oder Lock existiert noch: $LOCK_DIR"
fi
trap 'rmdir "$LOCK_DIR" 2>/dev/null || true' EXIT

if [[ ! -d "$SOURCE" ]]; then
  fail "Quellordner fehlt: $SOURCE"
fi

if [[ ! -f "$EXCLUDES" ]]; then
  fail "Exclude-Datei fehlt: $EXCLUDES"
fi

calculate_hash() {
  python3 - "$SOURCE" <<'PY'
import hashlib
import os
import sys

source = os.path.abspath(sys.argv[1])
skip_dirs = {
    "node_modules", "vendor", ".next", ".turbo", "dist", "build", ".cache",
    ".parcel-cache", ".vite", ".nuxt", ".output", ".vercel", ".svelte-kit",
    "coverage", "playwright-report", "test-results", "__pycache__",
    ".ipynb_checkpoints", ".pytest_cache", ".mypy_cache", ".ruff_cache",
    ".venv", "venv", ".build", "DerivedData",
}
skip_names = {".DS_Store", "gc.pid", "index.lock", "fsmonitor--daemon.ipc"}
skip_suffixes = (".pyc", ".pyo", ".log", ".xcarchive")

digest = hashlib.sha256()

for root, dirs, files in os.walk(source, topdown=True, followlinks=False):
    dirs[:] = [
        name for name in dirs
        if name not in skip_dirs
    ]
    rel_root = os.path.relpath(root, source)
    rel_root = "" if rel_root == "." else rel_root
    if "/.git/refs/codex/turn-diffs" in f"/{rel_root}":
        dirs[:] = []
        continue

    for name in sorted(files):
        if name in skip_names or name.endswith(skip_suffixes):
            continue
        path = os.path.join(root, name)
        rel = os.path.relpath(path, source)
        if "/.git/refs/codex/turn-diffs/" in f"/{rel}":
            continue
        try:
            st = os.lstat(path)
        except OSError:
            continue
        digest.update(rel.encode("utf-8", "surrogateescape"))
        digest.update(b"\0")
        if os.path.islink(path):
            digest.update(b"symlink\0")
            try:
                digest.update(os.readlink(path).encode("utf-8", "surrogateescape"))
            except OSError:
                pass
            digest.update(b"\0")
            continue
        if not os.path.isfile(path):
            continue
        digest.update(str(st.st_size).encode())
        digest.update(b"\0")
        with open(path, "rb") as handle:
            for chunk in iter(lambda: handle.read(1024 * 1024), b""):
                digest.update(chunk)
        digest.update(b"\0")

print(digest.hexdigest())
PY
}

is_mounted_volume() {
  local volume="$1"
  mount | grep -F " on $volume " >/dev/null 2>&1
}

rsync_backup() {
  local root="$1"
  local label="$2"
  local dest="$root/$DATE"
  local partial="$root/.partial-$DATE"
  local latest="$root/latest"

  mkdir -p "$root" || return 1
  rm -rf "$partial"
  mkdir -p "$partial" || return 1

  log "[INFO] Starte $label Backup nach $partial"

  /usr/bin/rsync -rtl --delete --delete-excluded \
    --exclude-from="$EXCLUDES" \
    "$SOURCE/" "$partial/"
  local rsync_status=$?

  if [[ "$rsync_status" -ne 0 ]]; then
    log "[ERROR] rsync für $label fehlgeschlagen mit Status $rsync_status"
    rm -rf "$partial"
    return "$rsync_status"
  fi

  printf 'completed_at=%s\nsource=%s\n' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$SOURCE" > "$partial/.backup-success"

  rm -rf "$dest"
  mv "$partial" "$dest" || return 1
  rm -f "$latest"
  ln -s "$dest" "$latest" 2>/dev/null || true

  log "[INFO] $label Backup erfolgreich: $dest"
  return 0
}

cleanup_old_backups() {
  local root="$1"
  [[ -d "$root" ]] || return 0

  find "$root" -mindepth 1 -maxdepth 1 -type d -name '.partial-*' -mtime +1 -exec rm -rf {} +
  find "$root" -mindepth 1 -maxdepth 1 -type d ! -name '.partial-*' -mtime +"$RETENTION_DAYS" -exec rm -rf {} +

  while [[ "$(du -sk "$root" 2>/dev/null | awk '{print $1}')" -gt "$MAX_KB" ]]; do
    local oldest
    local count
    oldest="$(find "$root" -mindepth 1 -maxdepth 1 -type d ! -name '.partial-*' | LC_ALL=C sort | head -n 1)"
    count="$(find "$root" -mindepth 1 -maxdepth 1 -type d ! -name '.partial-*' | wc -l | tr -d ' ')"

    if [[ -z "$oldest" || "$count" -le 1 ]]; then
      log "[WARNUNG] Speicherlimit überschritten, aber mindestens ein Backup bleibt erhalten: $root"
      break
    fi

    log "[INFO] Speicherlimit überschritten, lösche ältestes Backup: $oldest"
    rm -rf "$oldest"
  done
}

NEW_HASH="$(calculate_hash)"
LAST_ICLOUD="$(cat "$HASH_ICLOUD" 2>/dev/null || true)"
LAST_EXTERNAL="$(cat "$HASH_EXTERNAL" 2>/dev/null || true)"

success_count=0
failure_count=0
needed_count=0

if [[ -n "$NEW_HASH" && "$NEW_HASH" == "$LAST_ICLOUD" ]]; then
  log "[INFO] iCloud Backup ist bereits aktuell."
else
  needed_count=$((needed_count + 1))
  if rsync_backup "$ICLOUD_ROOT" "iCloud"; then
    printf '%s\n' "$NEW_HASH" > "$HASH_ICLOUD"
    success_count=$((success_count + 1))
  else
    log "[ERROR] iCloud Backup fehlgeschlagen."
    failure_count=$((failure_count + 1))
  fi
fi

if [[ -n "$NEW_HASH" && "$NEW_HASH" == "$LAST_EXTERNAL" ]]; then
  log "[INFO] Externes Backup ist bereits aktuell."
else
  needed_count=$((needed_count + 1))
  if is_mounted_volume "$EXT_VOLUME"; then
    if rsync_backup "$EXT_ROOT" "externes"; then
      printf '%s\n' "$NEW_HASH" > "$HASH_EXTERNAL"
      success_count=$((success_count + 1))
    else
      log "[ERROR] Externes Backup fehlgeschlagen."
      failure_count=$((failure_count + 1))
    fi
  else
    log "[ERROR] Externe Festplatte ist nicht gemountet und externes Backup ist nicht aktuell: $EXT_VOLUME"
    failure_count=$((failure_count + 1))
  fi
fi

if [[ "$needed_count" -eq 0 ]]; then
  log "[INFO] Keine relevanten Änderungen erkannt, alle Backup-Ziele sind aktuell."
  exit 0
fi

if [[ "$success_count" -eq 0 ]]; then
  fail "Kein benötigtes Backup-Ziel war erfolgreich."
fi

cleanup_old_backups "$ICLOUD_ROOT"
if is_mounted_volume "$EXT_VOLUME"; then
  cleanup_old_backups "$EXT_ROOT"
fi

if [[ "$failure_count" -gt 0 ]]; then
  fail "Backup teilweise abgeschlossen. Erfolgreiche Ziele: $success_count, fehlgeschlagene Ziele: $failure_count"
fi

log "[INFO] Backup abgeschlossen. Erfolgreiche Ziele: $success_count"
