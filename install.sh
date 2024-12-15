#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install packages for Arch
install_arch() {
    sudo pacman -Syu --noconfirm \
        git \
        zsh \
        tmux \
        i3 \
        picom \
        alacritty \
        feh \
        maim \
        xorg \
        xorg-xinit \
        xinput \
        dex \
        dmenu \
        i3blocks \
        stow \
        curl \
        powerline-fonts \
        ttf-nerd-fonts-complete
}

# Function to install packages for Ubuntu
install_ubuntu() {
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y \
        git \
        zsh \
        tmux \
        i3 \
        picom \
        alacritty \
        feh \
        maim \
        xorg \
        xorg-xinit \
        xinput \
        dex \
        dmenu \
        i3blocks \
        stow \
        curl \
        fonts-powerline \
        fonts-font-awesome \
        ttf-nerd-fonts-complete
}

# Ask the user to select the distribution
echo "Select your Linux distribution:"
echo "1) Arch Linux"
echo "2) Ubuntu"
read -p "Enter 1 or 2: " DISTRO_SELECTION

# Handle user input for distro selection
case $DISTRO_SELECTION in
    1)
        DISTRO="arch"
        ;;
    2)
        DISTRO="ubuntu"
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac

# Install necessary packages based on the distribution
if [ "$DISTRO" == "arch" ]; then
    echo "Installing packages for Arch Linux..."
    install_arch
elif [ "$DISTRO" == "ubuntu" ]; then
    echo "Installing packages for Ubuntu..."
    install_ubuntu
fi

# Stow all dotfiles
echo "Creating symlinks for dotfiles using Stow..."
stow .

# Change shell to Zsh (if Zsh is installed)
echo "Changing default shell to Zsh..."
chsh -s $(which zsh)

# Apply i3 wallpaper (adjust the path if necessary)
echo "Setting up wallpaper..."
feh --bg-scale ~/.config/i3/images/nature3.jpg

# Set up touchpad settings (adjust the device name if necessary)
echo "Setting up touchpad settings..."
xinput set-prop "ASUE1301:00 04F3:3128 Touchpad" "libinput Tapping Enabled" 1

# Reload i3 or restart the session
echo "Reloading i3 configuration..."
i3-msg restart

# Final message
echo "Dotfiles installation complete. Please restart your session or run 'i3-msg restart' to apply all configurations."
