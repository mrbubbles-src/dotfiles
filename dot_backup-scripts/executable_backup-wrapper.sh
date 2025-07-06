#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_DIR="$HOME/.backup-scripts/log"
LOG_FILE="$LOG_DIR/backup-dev_$DATE.log"
ERR_FILE="$LOG_DIR/backup-dev-error_$DATE.log"

mkdir -p "$LOG_DIR"
/usr/bin/env zsh "$HOME/.backup-scripts/backup-dev.sh" > "$LOG_FILE" 2> "$ERR_FILE"

ls -1t "$HOME/.backup-scripts/log"/backup-dev*.log | tail -n +8 | xargs -I {} rm -f {}
ls -1t "$HOME/.backup-scripts/log"/backup-dev-error*.log | tail -n +8 | xargs -I {} rm -f {}