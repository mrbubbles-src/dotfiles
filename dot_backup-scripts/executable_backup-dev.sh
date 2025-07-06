#!/bin/zsh

DATE=$(date +"%Y-%m-%d_%H-%M")
LOG_PREFIX="$HOME/.backup-scripts/log"
DEST_ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs/dev-backups/$DATE"
DEST_EXT="/Volumes/Data/dev-backups/$DATE"
EXCLUDES="$HOME/.dev-backup-exclude"
HASH_FILE="$HOME/.backup-scripts/last-dev-hash.txt"

mkdir -p "$LOG_PREFIX"

# 🧠 Funktion: Änderungs-Hash über alle Dateien im dev-Ordner – mit fest eingebauten Excludes
calculate_hash() {
  find "$HOME/dev" -type f \
    ! -path "*/node_modules/*" \
    ! -name ".DS_Store" \
    -exec shasum "{}" + 2>/dev/null | shasum
}

# 📌 Änderungscheck via Hash
NEW_HASH=$(calculate_hash)
LAST_HASH=$(cat "$HASH_FILE" 2>/dev/null || echo "")

if [ "$NEW_HASH" = "$LAST_HASH" ]; then
  echo "[INFO] Keine Änderungen erkannt – Backup wird heute nicht erstellt." >> "$LOG_PREFIX/backup-dev-$(date +"%Y-%m-%d_%H-%M").log"
  exit 0
else
  echo "$NEW_HASH" > "$HASH_FILE"
fi

# 📦 Backup in iCloud
rsync -av --exclude-from="$EXCLUDES" "$HOME/dev/" "$DEST_ICLOUD"

# 📦 Backup auf externer Festplatte (falls vorhanden)
if [ -d "/Volumes/Data" ]; then
  rsync -av --exclude-from="$EXCLUDES" "$HOME/dev/" "$DEST_EXT"
else
  echo "[WARNUNG] Externe Festplatte '/Volumes/Data' nicht verfügbar – Backup nur in iCloud erstellt." >> "$LOG_PREFIX/backup-dev-error-$(date +"%Y-%m-%d_%H-%M").log"
fi

# 🧹 Alte Backups löschen (älter als 7 Tage)
find "$HOME/Library/Mobile Documents/com~apple~CloudDocs/dev-backups" -mindepth 1 -maxdepth 1 -type d -mtime +6 -exec rm -rf {} +
find "/Volumes/Data/dev-backups" -mindepth 1 -maxdepth 1 -type d -mtime +6 -exec rm -rf {} +

# 💾 Max 100 GB Speicher pro Zielordner
cleanup_if_exceeds() {
  DIR="$1"
  MAX_KB=102400000

  while [ "$(du -sk "$DIR" | awk '{print $1}')" -gt "$MAX_KB" ]; do
    OLDEST=$(find "$DIR" -mindepth 1 -maxdepth 1 -type d | sort | head -n 1)
    COUNT=$(find "$DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)

    if [ "$COUNT" -le 1 ]; then
      echo "[WARNUNG] Speicherlimit überschritten – mindestens ein Backup wird behalten ($DIR)" >> "$LOG_PREFIX/backup-dev-error-$(date +"%Y-%m-%d_%H-%M").log"
      break
    fi

    echo "[INFO] Speicherlimit überschritten – lösche ältestes Backup: $OLDEST" >> "$LOG_PREFIX/backup-dev-$(date +"%Y-%m-%d_%H-%M").log"
    rm -rf "$OLDEST"
  done
}

cleanup_if_exceeds "$HOME/Library/Mobile Documents/com~apple~CloudDocs/dev-backups"
[ -d "/Volumes/Data/dev-backups" ] && cleanup_if_exceeds "/Volumes/Data/dev-backups"