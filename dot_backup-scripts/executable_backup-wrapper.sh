#!/bin/bash
set -u

DATE="$(date +"%Y-%m-%d_%H-%M-%S")"
LOG_DIR="$HOME/.backup-scripts/log"
LOG_FILE="$LOG_DIR/backup-dev_$DATE.log"
ERR_FILE="$LOG_DIR/backup-dev-error_$DATE.log"

mkdir -p "$LOG_DIR"

if /usr/bin/env zsh "$HOME/.backup-scripts/backup-dev.sh" > "$LOG_FILE" 2> "$ERR_FILE"; then
  echo "[INFO] Backup wrapper completed successfully at $(date +"%Y-%m-%d %H:%M:%S")" >> "$LOG_FILE"
else
  status=$?
  echo "[ERROR] Backup wrapper failed with status $status at $(date +"%Y-%m-%d %H:%M:%S")" >> "$ERR_FILE"
  exit "$status"
fi

python3 - "$LOG_DIR" <<'PY'
import sys
from pathlib import Path

log_dir = Path(sys.argv[1])
for pattern in ("backup-dev*.log", "backup-dev-error*.log"):
    files = sorted(
        log_dir.glob(pattern),
        key=lambda path: path.stat().st_mtime,
        reverse=True,
    )
    for path in files[14:]:
        path.unlink(missing_ok=True)
PY
