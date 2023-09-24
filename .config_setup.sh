#!/bin/bash

repo_name="extra"  # Change this to the name of the repository you want to enable

# Check if the repository is already enabled
if grep -q "^\[$repo_name\]" /etc/pacman.conf; then
    echo "Repository '$repo_name' is already enabled."
else
    # Add repository information to /etc/pacman.conf
    echo "Enabling repository '$repo_name'..."
    echo "[$repo_name]" | sudo tee -a /etc/pacman.conf
    echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf

    # Update package database
    sudo pacman -Sy

    echo "Repository '$repo_name' is now enabled."
fi

# Define an array of packages to check and install
pacman_pkg=("git" "networkmanager" "firefox" "gdm" "neovim" "hyprland" "noto-fonts" "noto-fonts-cjk" "noto-fonts-emoji" "ttf-firacode-nerd" "otf-font-awesome" "kitty" "starship" "hyprpaper" "ranger" "feh" "mpv" "udisks2")

# Loop through the array
for package in "${pacman_pkg[@]}"; do
    # Check if the package is installed
    if pacman -Q "$package" &>/dev/null; then
        echo "'$package' is already installed"
    else
        # Install the package using pacman -S
        echo "Installing '$package'..."
        sudo pacman -S --noconfirm "$package"
        if [ "$package" == "networkmanager" ]; then
            # Perform specific procedure for "networkmanager"
            echo "Configuring NetworkManager..."
            # Add your specific commands here
            sudo systemctl enable NetworkManager.service
        fi
        if [ "$package" == "gdm" ]; then
            # Perform specific procedure for "networkmanager"
            echo "Configuring GDM..."
            # Add your specific commands here
            sudo systemctl enable gdm.service
        fi
    fi
done

# Check if rustup is already installed
if command -v rustup &>/dev/null; then
    echo "Rust is already installed."
else
    # Download and run the rustup installer script
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Add rust to the current shell session
    . $HOME/.cargo/env
fi

# Define an array of packages to check and install
packages=("rtx-cli" "exa" "zellij" "procs" "bacon" "bat" "dezoomify-rs" "grex" "sqlx-cli" "ytop" "xh" "mprocs")

# Loop through the array
for package in "${packages[@]}"; do
    # Check if the package is installed
    if command -v "$package" &>/dev/null; then
        echo "'$package' is already installed"
    else
        # Download and install the package
        echo "Installing '$package'..."
        cargo-binstall "$package"
    fi
done

# Check if bun is already installed
if command -v bun &>/dev/null; then
    echo "bun is already installed."
else
    # Download and run the bun installer script
    curl -fsSL https://bun.sh/install | bash
fi

rtx_pkg=("node" "dotnet" "java" "go" "python")

# Loop through the array
for package in "${rtx_pkg[@]}"; do
    # Download and install the package
    echo "Installing '$package'..."
    rtx install "$package"
    rtx use -g "$package"
done

# Add dotfile bare git repo
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/grepvenancio/dotfiles.git $HOME/.dotfiles

# Go to home
cd 
mkdir -p "Projects"  # The -p flag ensures parent directories are created if needed 
cd Projects
# Clone yay repo
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Install ms-edge
yay -S microsoft-edge-stable-bin
