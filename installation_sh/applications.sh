#!/bin/bash

# Check if any package manager is installed
YAY=$(which yay)
PARU=$(which paru)

if [ -z "$YAY" ] && [ -z "$PARU" ]; then
  echo "Error: Neither 'yay' nor 'paru' are installed."
  exit 1
fi

# Determine which one is actually installed (not aliased)
if command -v paru &> /dev/null; then
  PACKAGE_MANAGER="$PARU"
elif command -v yay &> /dev/null; then
  PACKAGE_MANAGER="$YAY"
else
  echo "Error: Unable to determine the actual package manager."
  exit 1
fi

echo "Using $PACKAGE_MANAGER for package management."

echo "Removing i3-lock"
$PACKAGE_MANAGER -Rns i3lock

# Define a function to check if a package is installed
check_installed() {
  local package=$1
  if ! command -v $package &> /dev/null; then
    echo "Package '$package' is not installed. Installing..."
    sudo -u $(id -un) $PACKAGE_MANAGER -S --noconfirm $package || { echo "Failed to install $package. Exiting."; exit 1; }
  fi
}

# Check and install each package
packages=(
  yazi
  tmux
  bc
  fzf
  curl
  feh
  xset
  xautolock
  dunst
  autotiling
  alacritty
  kitty
  rofi
  maim
  unclutter
  ranger
  ttc-iosevka
  jq
  i3lock-color
  xkblayout-state-git
  ntfs-3g
)

for package in "${packages[@]}"; do
  check_installed $package
done

echo "All packages installed."
