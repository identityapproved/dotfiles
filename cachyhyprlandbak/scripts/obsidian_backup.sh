#!/usr/bin/env bash

# crontab -e
# 0 19 * * * /home/identityapproved/.config/scripts/obsidian_backup.sh >> /home/identityapproved/.local/share/obsidian_backup.log 2>&1

# Path to your vault
VAULT="$HOME/Documents/second_brains"
# Mountpoint of your external drive
DRIVE_MOUNT="$HOME/drives/transcend"
# Where on the drive to put backups
BACKUP_ROOT="$DRIVE_MOUNT/obsidian_backups"
TIMESTAMP=$(date '+%Y-%m-%d_%H%M')
DEST="$BACKUP_ROOT/$TIMESTAMP"

# 1) Ensure the drive is mounted
if ! mountpoint -q "$DRIVE_MOUNT"; then
	echo "Obsidian Backup: drive not mounted at $DRIVE_MOUNT. Backup at $TIMESTAMP aborted."
	exit 1
fi

# 2) Create a timestamped backup directory
mkdir -p "$DEST"

# 3) Run rsync
rsync -a --progress --stats --human-readable \
	"$VAULT/" "$DEST/" >/dev/null 2>&1

if [[ $? -eq 0 ]]; then
	if command -v notify-send >/dev/null && [ -n "$DISPLAY" ]; then
		notify-send "Obsidian Backup" "Backup completed successfully."
	else
		echo "[INFO] Obsidian backup ($TIMESTAMP) completed."
	fi
else
	echo "[INFO] Obsidian Backup: backup at $TIMESTAMP FAILED for $VAULT → $DEST"
	exit 1
fi
