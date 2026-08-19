#!/bin/bash

# masternaka-i3wm Configuration
# https://github.com/Masternaka/masternaka-i3wm

set -e

# Command line options
ONLY_CONFIG=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --only-config)
            ONLY_CONFIG=true
            shift
            ;;
        --help)
            echo "Usage: $0 [OPTIONS]"
            echo "  --only-config      Only copy config files (skip packages and external tools)"
            echo "  --help            Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/i3"
TEMP_DIR="/tmp/i3_$$"
LOG_FILE="$HOME/i3-install.log"

# Logging and cleanup
exec > >(tee -a "$LOG_FILE") 2>&1
trap "rm -rf $TEMP_DIR" EXIT

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

die() { echo -e "${RED}ERROR: $*${NC}" >&2; exit 1; }
warn() { echo -e "${YELLOW}WARNING: $*${NC}" >&2; }
msg() { echo -e "${CYAN}$*${NC}"; }


# Banner
clear
echo -e "${CYAN}"
echo " +-+-+-+-+-+-+-+-+-+-+-+-+-+ "
echo " |m|a|s|t|e|r|n|a|k|a| "
echo " +-+-+-+-+-+-+-+-+-+-+-+-+-+ "
echo " |i|3|w m| |c|o|n|f|i|g          | "
echo " +-+-+-+-+-+-+-+-+-+-+-+-+-+ "
echo -e "${NC}\n"

read -p "Install i3? (y/n) " -n 1 -r
echo
[[ ! $REPLY =~ ^[Yy]$ ]] && exit 1

# Update system
if [ "$ONLY_CONFIG" = false ]; then
    msg "Updating system..."
    sudo apt-get update && sudo apt-get upgrade -y
else
    msg "Skipping system update (--only-config mode)"
fi

# Package groups for better organization
PACKAGES_CORE=(
    xorg xorg-dev xbacklight xbindkeys xvkbd xinput
    build-essential i3 sxhkd xdotool dbus-x11
    libnotify-bin libnotify-dev
)

PACKAGES_UI=(
    polybar dunst feh nwg-look xsettingsd network-manager-gnome lxpolkit variety
)

PACKAGES_FILE_MANAGER=(
    thunar thunar-archive-plugin thunar-volman
    gvfs-backends gvfs-fuse dialog mtools smbclient cifs-utils fd-find unzip
)

PACKAGES_AUDIO=(
    pavucontrol pulsemixer pamixer pipewire-audio
)

PACKAGES_UTILITIES=(
    avahi-daemon acpi acpid xfce4-power-manager
    flameshot qimgv xdg-user-dirs-gtk gsimplecal arandr autotiling
)

PACKAGES_TERMINAL=(
    suckless-tools
)

PACKAGES_FONTS=(
    fonts-recommended fonts-font-awesome fonts-terminus
)

PACKAGES_BUILD=(
    cmake meson ninja-build curl pkg-config wget
)


# Install packages by group
if [ "$ONLY_CONFIG" = false ]; then
    msg "Installing core packages..."
    sudo apt-get install -y "${PACKAGES_CORE[@]}" || die "Failed to install core packages"

    msg "Installing UI components..."
    sudo apt-get install -y "${PACKAGES_UI[@]}" || die "Failed to install UI packages"

    msg "Installing file manager..."
    sudo apt-get install -y "${PACKAGES_FILE_MANAGER[@]}" || die "Failed to install file manager"

    msg "Installing audio support..."
    sudo apt-get install -y "${PACKAGES_AUDIO[@]}" || die "Failed to install audio packages"

    msg "Installing system utilities..."
    sudo apt-get install -y "${PACKAGES_UTILITIES[@]}" || die "Failed to install utilities"
    
    # Try firefox-esr first (Debian), then firefox (Ubuntu)
    sudo apt-get install -y firefox-esr 2>/dev/null || sudo apt-get install -y firefox 2>/dev/null || msg "Note: firefox not available, skipping..."

    msg "Installing terminal tools..."
    sudo apt-get install -y "${PACKAGES_TERMINAL[@]}" || die "Failed to install terminal tools"
    
    # eza is the Debian 13 name; exa fallback for older bases
    sudo apt-get install -y eza 2>/dev/null || sudo apt-get install -y exa 2>/dev/null || msg "Note: exa/eza not available, skipping..."

    msg "Installing fonts..."
    sudo apt-get install -y "${PACKAGES_FONTS[@]}" || die "Failed to install fonts"

    msg "Installing build dependencies..."
    sudo apt-get install -y "${PACKAGES_BUILD[@]}" || die "Failed to install build tools"

    # Enable services
    sudo systemctl enable avahi-daemon acpid
else
    msg "Skipping package installation (--only-config mode)"
fi

# Handle existing config
if [ -d "$CONFIG_DIR" ]; then
    clear
    read -p "Found existing i3 config. Backup? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv "$CONFIG_DIR" "$CONFIG_DIR.bak.$(date +%s)"
        msg "Backed up existing config"
    else
        clear
        read -p "Overwrite without backup? (y/n) " -n 1 -r
        echo
        [[ $REPLY =~ ^[Yy]$ ]] || die "Installation cancelled"
        rm -rf "$CONFIG_DIR"
    fi
fi

# Copy configs
msg "Setting up configuration..."
mkdir -p "$CONFIG_DIR"

# Copy i3 config files
cp -r "$SCRIPT_DIR"/i3/* "$CONFIG_DIR"/ || die "Failed to copy i3 config"

# Configuration directories are already in the i3 folder, so we don't need to copy them separately

# Make scripts executable
find "$CONFIG_DIR"/scripts -type f -exec chmod +x {} \; 2>/dev/null || true

# Setup directories
xdg-user-dirs-update
mkdir -p ~/Screenshots

# Drop quickstart cheatsheet in $HOME (user can delete once read)
if [ -f "$SCRIPT_DIR/QUICKSTART.md" ]; then
    cp "$SCRIPT_DIR/QUICKSTART.md" "$HOME/QUICKSTART-i3.md"
fi

# Install essential components
if [ "$ONLY_CONFIG" = false ]; then
    mkdir -p "$TEMP_DIR" && cd "$TEMP_DIR"

    msg "Installing picom..."
    sudo apt-get install -y picom || die "Failed to install picom"

    msg "Installing rofi..."
    sudo apt-get install -y rofi || die "Failed to install rofi"
    
    msg "Installing kitty..."
    get_script "kitty/install_kitty.sh" || warn "Kitty installation failed - you can install it manually later"

    msg "Installing fonts..."
    get_script "theming/install_nerdfonts.sh" || warn "Font installation failed - you can install fonts manually later"

    msg "Installing themes..."
    get_script "theming/install_theme.sh" || warn "Theme installation failed - you can install themes manually later"

    msg "Downloading wallpaper directory..."
    if [ ! -d "$CONFIG_DIR/wallpaper" ]; then
        git clone --depth 1 --progress git@github.com:Masternaka/Wallpapers.git "$CONFIG_DIR/wallpaper" || die "Failed to clone wallpapers"
        rm -rf "$CONFIG_DIR/wallpaper/.git"
    else
        msg "Wallpaper directory already exists, skipping..."
    fi

    msg "Downloading display manager installer..."
    wget -O "$TEMP_DIR/install_lightdm.sh" "https://github.com/Masternaka/Masterscripts_Debian/main/system/install_lightdm.sh"
    chmod +x "$TEMP_DIR/install_lightdm.sh" 
    msg "Running display manager installer..."
    # Run in current terminal session to preserve interactivity
    bash "$TEMP_DIR/install_lightdm.sh"

 # Optional tools
    clear
    read -p "Install optional tools (browsers, editors, etc)? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        msg "Downloading optional tools installer..."
        wget -O "$TEMP_DIR/optional_tools.sh" "https://github.com/Masternaka/Masterscripts_Debian/main/setup/optional_tools.sh"
        chmod +x "$TEMP_DIR/optional_tools.sh"
        msg "Running optional tools installer..."
        # Run in current terminal session to preserve interactivity
        if bash "$TEMP_DIR/optional_tools.sh"; then
            msg "Optional tools completed successfully"
        else
            msg "Optional tools exited (this is normal if cancelled by user)"
        fi
    fi
else
    msg "Skipping external tool installation (--only-config mode)"
fi

# Ensure ~/.local/bin is on PATH for display-manager logins.
# DM sessions source ~/.xsessionrc but never ~/.profile, so user-built tools
# in ~/.local/bin would otherwise be unfindable when launched from the WM.
if ! grep -qs '.local/bin' "$HOME/.xsessionrc" 2>/dev/null; then
    msg "Ensuring ~/.local/bin is on PATH via ~/.xsessionrc..."
    cat >> "$HOME/.xsessionrc" <<'XSESSIONRC_EOF'

# Added by justaguylinux setup: ensure ~/.local/bin is on PATH
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) PATH="$HOME/.local/bin:$PATH"; export PATH ;;
esac
XSESSIONRC_EOF
fi

# Done
echo -e "\n${GREEN}Installation complete!${NC}"
echo "1. Log out and select 'i3' from your display manager"
echo "2. Press Super + / for keybindings"
echo "3. See ~/QUICKSTART-i3.md for a quick reference"
