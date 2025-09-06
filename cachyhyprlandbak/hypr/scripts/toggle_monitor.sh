#!/bin/bash

# Configuration
MONITOR="DVI-D-1"
LOG_FILE="/tmp/hyprland_monitor_toggle.log"
DEBUG=true

# Logging function
log() {
	if [ "$DEBUG" = true ]; then
		echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
	fi
}

# Start logging
log "=== Starting monitor toggle script ==="
log "Monitor: $MONITOR"
log "Current hyprctl monitors output:"
hyprctl monitors | tee -a "$LOG_FILE"

# Check if monitor is present and not disabled
if hyprctl monitors | grep -A 10 "$MONITOR" | grep -q "disabled: true"; then
	STATUS="disabled"
else
	STATUS="enabled"
fi

log "Detected status: $STATUS"

# Toggle monitor
if [ "$STATUS" = "disabled" ]; then
	log "Enabling monitor $MONITOR"
	hyprctl keyword monitor "$MONITOR,preferred,auto,1" 2>&1 | tee -a "$LOG_FILE"
	RESULT=$?
else
	log "Disabling monitor $MONITOR"
	hyprctl keyword monitor "$MONITOR,disable" 2>&1 | tee -a "$LOG_FILE"
	RESULT=$?
fi

# Verify action
sleep 1 # Give Hyprland more time to process the change
log "Updated hyprctl monitors output:"
hyprctl monitors | tee -a "$LOG_FILE"

if hyprctl monitors | grep -A 10 "$MONITOR" | grep -q "disabled: true"; then
	NEW_STATUS="disabled"
else
	NEW_STATUS="enabled"
fi

if [ "$RESULT" -eq 0 ] && [ "$STATUS" != "$NEW_STATUS" ]; then
	log "Successfully toggled monitor $MONITOR"
else
	log "ERROR: Failed to toggle monitor $MONITOR"
	log "Exit code: $RESULT"
	log "Status before: $STATUS, after: $NEW_STATUS"
	log "Trying alternative method..."

	# Alternative approach using hyprctl
	if [ "$STATUS" = "disabled" ]; then
		hyprctl dispatch dpms on "$MONITOR" 2>&1 | tee -a "$LOG_FILE"
	else
		hyprctl dispatch dpms off "$MONITOR" 2>&1 | tee -a "$LOG_FILE"
	fi
fi

log "=== Script complete ==="
