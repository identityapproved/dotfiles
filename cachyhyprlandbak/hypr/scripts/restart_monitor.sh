#!/bin/bash

MONITOR="DVI-D-1"

if hyprctl monitors | grep -A 10 "$MONITOR" | grep -q "disabled: true"; then
	# Full reset when monitor is disabled
	hyprctl keyword monitor "$MONITOR,preferred,auto,1"
	sleep 1
	hyprctl reload
else
	# Turn off monitor
	hyprctl keyword monitor "$MONITOR,disable"
fi
