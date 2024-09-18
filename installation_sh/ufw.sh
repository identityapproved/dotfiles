#!/bin/bash

# Install ufw if not installed
if command -v paru &> /dev/null; then
  PACKAGE_MANAGER="$PARU"
elif command -v yay &> /dev/null; then
  PACKAGE_MANAGER="$YAY"
else
  if ! $PACKAGE_MANAGER -Qi ufw >/dev/null 2>&1; then
    echo "Installing ufw using $PACKAGE_MANAGER for package management."
    $PACKAGE_MANAGER -S --noconfirm ufw
  else
    echo "Error: Unable to determine the actual package manager."
    exit 1
  fi
fi

# Disable ufw if it's enabled
ufw disable

# Reset all firewall rules
ufw --force reset

# Set firewall rules
ufw limit 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw default deny incoming
ufw default allow outgoing

# Enable ufw at system startup
systemctl enable ufw.service

# Start and enable the firewall immediately
systemctl start ufw.service
echo "Firewall is enabled."

# List all firewall rules
ufw status verbose
