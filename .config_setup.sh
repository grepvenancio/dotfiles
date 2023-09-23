#!/bin/bash

# Check if the repository is already enabled
repo_name="extra"  # Change this to the name of the repository you want to enable

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
pacman_pkg=("git" "pipewire" "networkmanager" "firefox" "gdm" "neovim" "hyprland" "pipewire-alsa" "pipewire-jack" "pipewire-audio" "noto-fonts" "noto-fonts-cjk" "noto-fonts-emoji" "ttf-firacode-nerd" "kitty")

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

# Check if bin-install is already installed
if command -v cargo-binstall &>/dev/null; then
    echo "cargo-binstall is already installed."
else
    # Download cargo-binstall
    cargo install cargo-binstall
fi


# Define an array of packages to check and install
packages=("rtx-cli" "exa" "zellij" "procs" "bacon" "bat" "dezoomify-rs" "dust" "fd" "grex" "sqlx" "ytop" "xh" "mprocs" "tldr" "rg" "gitui")

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

# Set the keyboard layout to br-abnt2
layout="br"
variant="abnt2"

setxkbmap -layout $layout -variant $variant


rtx_pkg=("node" "dotnet" "java" "go" "python")

# Loop through the array
for package in "${rtx_pkg[@]}"; do
    # Check if the package is installed
    if command -v "$package" &>/dev/null; then
        echo "'$package' is already installed"
    else
        # Download and install the package
        echo "Installing '$package'..."
        rtx install "$package"
        rtx use -g "$package"
    fi
done

# Add dotfile bare git repo
echo ".dotfiles" >> .gitignore
git clone https://github.com/grepvenancio/dotfiles.git $HOME/.dotfiles

# Check if yay is installed
if ! command -v yay &>/dev/null; then
    echo "Yay is not installed. Please install yay first."
    exit 1
fi

# Check if the user repository is already enabled
if grep -qE '^#\[yay\]' /etc/yay.conf; then
    echo "User repository is already enabled."
else
    # Uncomment the user repository section in /etc/yay.conf
    echo "Enabling user repository..."
    sudo sed -i 's/^#\(\[yay\]\)/\1/' /etc/yay.conf

    echo "User repository is now enabled."
fi
