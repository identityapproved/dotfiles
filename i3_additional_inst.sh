#!/bin/bash

echo "Choose a compositor to install:"
echo "[1] xcompmgr | [2] picom"

read -p "Enter the number of your choice (default [1]): " choice

# Set default choice to xcompmgr if the input is empty
choice=${choice:-1}

# Check the user's choice and install the corresponding compositor
case $choice in
  1)
    # Check if xcompmgr is already installed
    if command -v xcompmgr >/dev/null 2>&1; then
      echo "xcompmgr is already installed."
    else
      # Install xcompmgr
      yay -S --noconfirm xcompmgr
      echo "xcompmgr has been installed."
    fi
    ;;

  2)
    # Check if picom is already installed
    if command -v picom >/dev/null 2>&1; then
      echo "picom is already installed."
    else
      # Install picom
      yay -S --noconfirm picom
      echo "picom has been installed."
    fi
    ;;

  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

# Install autotiling
echo "Installing https://github.com/nwg-piotr/autotiling"
yay -S autotiling
