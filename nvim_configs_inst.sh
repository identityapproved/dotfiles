#!/bin/bash

# Specify the main configuration directory
CONFIG_DIR="$HOME/.config"

# Function to install Neovim
install_neovim() {
  yay -S --noconfirm neovim
}

# Function to check and install prerequisites for LunarVim
install_lunarvim_prerequisites() {
  # Check and install cargo (Rust)
  if ! command -v cargo >/dev/null 2>&1; then
    echo "cargo is not installed. Installing cargo. RUSTUP!"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi

  # Check and install other prerequisites
  yay -S --noconfirm git make python python-pip 

  # Additional steps to resolve EACCES permissions for npm
  # (you may need to adjust this based on your specific setup)
  # sudo chown -R $USER:$(id -gn) /usr/local/{lib/node_modules,bin,share}

}

# Function to install LunarVim
install_lunarvim() {
  echo "Choose LunarVim release:"
  echo "[1] Stable | [2] Nightly"

  read -p "(default - [1] Stable): " release_choice

  # Set default choice to stable if the input is empty
  release_choice=${release_choice:-1}

  case $release_choice in
    1)
      # Install LunarVim stable release
      bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/stable/utils/installer/install.sh)
      ;;
    2)
      # Install LunarVim nightly release
      bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
      ;;
    *)
      echo "Invalid choice. Exiting."
      exit 1
      ;;
  esac
}

# Function to clone additional Neovim configurations
clone_additional_configs() {
  configs=(
    "nvim-astrovim"
    "nvim-kickstart"
    "nvim-lazyvim"
    "nvim-nvchad"
  )

  mkdir -p "${configs[@]/#/$CONFIG_DIR/}" && echo "Created directories: ${configs[@]/#/$CONFIG_DIR/}"

  for config in "${configs[@]}"; do
    case $config in
      "nvim-astrovim")
        git clone --depth 1 "https://github.com/AstroNvim/AstroNvim" "$CONFIG_DIR/$config"
        ;;
      "nvim-kickstart")
        git clone "https://github.com/nvim-lua/kickstart.nvim.git" "$CONFIG_DIR/$config"
        ;;
      "nvim-lazyvim")
        git clone "https://github.com/LazyVim/starter" "$CONFIG_DIR/$config"
        ;;
      "nvim-nvchad")
        git clone --depth 1 "https://github.com/NvChad/NvChad" "$CONFIG_DIR/$config"
        ;;
      *)
        echo "Unknown configuration: $config"
        ;;
    esac
    echo "Cloned repository for $config"

    # Remove .git directory if it exists
    if [ -d "$CONFIG_DIR/$config/.git" ]; then
      rm -rf "$CONFIG_DIR/$config/.git"
      echo "Removed .git directory for $config"
    fi
  done
}

# Main script

# Install Neovim
install_neovim

# Install prerequisites for LunarVim
install_lunarvim_prerequisites

# Install LunarVim
install_lunarvim

# Clone additional Neovim configurations
clone_additional_configs

echo "Neovim and LunarVim setup completed."