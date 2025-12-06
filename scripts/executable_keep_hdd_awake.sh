#!/bin/bash
VOLS=("Backup Eins" "Backup Zwei")

for vol in "${VOLS[@]}"; do
  MOUNTPOINT="/Volumes/$vol"
  if mount | grep -q "on ${MOUNTPOINT} "; then
    /usr/bin/touch "$MOUNTPOINT/.keepawake"
  fi
done
