# Function to setup bash configuration
setup_bash() {
    print_header "CONFIGURING BASH & FASTFETCH"
    
    print_status "Setting up enhanced bashrc with funny aliases..."
    
    # Copy bashrc configuration
    if [[ -f "dotfiles/bashrc" ]]; then
        cp dotfiles/bashrc ~/.bashrc
        print_success "Enhanced bashrc applied (with funny aliases!)"
    else
        print_warning "dotfiles/bashrc not found in repository"
    fi
    
    # Setup fastfetch configuration
    print_status "Setting up fastfetch configuration..."
    mkdir -p ~/.config/fastfetch
    
    if [[ -f "dotfiles/fastfetch.jsonc" ]]; then
        cp dotfiles/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
        print_success "Fastfetch configuration applied"
    else
        print_warning "dotfiles/fastfetch.jsonc not found in repository"
    fi
}#!/bin/bash

# Arch Linux Setup Script
# Author: Your Name
# Description: Automated setup for Arch Linux environment

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}===========================================${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}===========================================${NC}"
}

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root"
        exit 1
    fi
}

# Function to backup existing configs
backup_configs() {
    print_status "Creating backups of existing configurations..."
    
    # Backup kitty config
    if [[ -f ~/.config/kitty/kitty.conf ]]; then
        cp ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.backup.$(date +%Y%m%d_%H%M%S)
        print_success "Kitty config backed up"
    fi
}

# Function to update system
update_system() {
    print_header "UPDATING SYSTEM"
    print_status "Updating package databases and system..."
    sudo pacman -Syu --noconfirm
    print_success "System updated successfully"
}

# Function to install essential packages
install_essential_packages() {
    print_header "INSTALLING ESSENTIAL PACKAGES"
    
    local packages=(
        "kitty"
        "git"
        "curl"
        "wget"
        "vim"
        "neovim"
        "base-devel"
        "fontconfig"
        "fastfetch"
        "ttf-jetbrains-mono-nerd"
        "ttf-firacode-nerd"
        "ttf-cascadia-code-nerd"
        "ttf-hack-nerd"
        "ttf-sourcecodepro-nerd"
    )
    
    print_status "Installing essential packages..."
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    print_success "Essential packages installed"
}

# Function to install development packages
install_dev_packages() {
    print_header "INSTALLING DEVELOPMENT PACKAGES"
    
    read -p "Do you want to install development packages? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        local dev_packages=(
            "python"
            "python-pip"
            "nodejs"
            "npm"
            "rust"
            "go"
            "docker"
            "docker-compose"
            "code"  # VS Code (if available)
        )
        
        print_status "Installing development packages..."
        sudo pacman -S --needed --noconfirm "${dev_packages[@]}"
        
        # Enable Docker service
        if systemctl is-enabled docker &>/dev/null; then
            print_status "Docker already enabled"
        else
            sudo systemctl enable --now docker
            sudo usermod -aG docker $USER
            print_success "Docker enabled and user added to docker group"
        fi
        
        print_success "Development packages installed"
    else
        print_status "Skipping development packages"
    fi
}

# Function to install AUR helper (yay)
install_aur_helper() {
    print_header "INSTALLING AUR HELPER (YAY)"
    
    if command -v yay &> /dev/null; then
        print_success "yay is already installed"
        return 0
    fi
    
    print_status "Installing yay AUR helper..."
    
    # Create temporary directory
    temp_dir=$(mktemp -d)
    cd "$temp_dir"
    
    # Clone and build yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    
    # Cleanup
    cd ~
    rm -rf "$temp_dir"
    
    print_success "yay installed successfully"
}

# Function to setup kitty configuration
setup_kitty() {
    print_header "CONFIGURING KITTY TERMINAL"
    
    print_status "Setting up Kitty configuration..."
    
    # Create kitty config directory
    mkdir -p ~/.config/kitty
    
    # Copy kitty configuration
    if [[ -f "kitty/kitty.conf" ]]; then
        cp kitty/kitty.conf ~/.config/kitty/
        print_success "Kitty configuration applied"
    else
        print_warning "kitty/kitty.conf not found in repository"
    fi
    
    # Refresh font cache
    print_status "Refreshing font cache..."
    fc-cache -fv
    print_success "Font cache refreshed"
}

# Function to install AUR packages
install_aur_packages() {
    print_header "INSTALLING AUR PACKAGES"
    
    read -p "Do you want to install additional AUR packages? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        local aur_packages=(
            "google-chrome"
            "discord"
            "spotify"
            "visual-studio-code-bin"
        )
        
        print_status "Installing AUR packages..."
        for package in "${aur_packages[@]}"; do
            print_status "Installing $package..."
            yay -S --noconfirm "$package" || print_warning "Failed to install $package"
        done
        
        print_success "AUR packages installation completed"
    else
        print_status "Skipping AUR packages"
    fi
}

# Function to apply final configurations
final_setup() {
    print_header "FINAL SETUP"
    
    print_status "Applying final configurations..."
    
    # Set kitty as default terminal (if using GNOME)
    if command -v gsettings &> /dev/null; then
        gsettings set org.gnome.desktop.default-applications.terminal exec 'kitty'
        print_success "Kitty set as default terminal"
    fi
    
    print_status "Setup completed!"
}

# Function to display post-installation notes
display_notes() {
    print_header "POST-INSTALLATION NOTES"
    
    echo -e "${CYAN}Setup completed successfully!${NC}"
    echo
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Restart your terminal or run: source ~/.bashrc"
    echo "2. If you installed Docker, log out and back in for group changes"
    echo "3. Open Kitty terminal to test the configuration"
    echo "4. Use Ctrl+Shift+F2 in Kitty to edit config on the fly"
    echo
    echo -e "${YELLOW}Useful commands:${NC}"
    echo "• Update system: sudo pacman -Syu"
    echo "• Update AUR packages: yay -Sua"
    echo "• Edit Kitty config: vim ~/.config/kitty/kitty.conf"
    echo
    echo -e "${GREEN}Enjoy your new Arch Linux setup! 🎉${NC}"
}

# Main execution
main() {
    print_header "ARCH LINUX SETUP SCRIPT"
    
    # Check if not running as root
    check_root
    
    # Create backups
    backup_configs
    
    # Update system
    update_system
    
    # Install packages
    install_essential_packages
    install_dev_packages
    
    # Install AUR helper
    install_aur_helper
    
    # Setup configurations
    setup_kitty
    setup_bash
    
    # Install AUR packages
    install_aur_packages
    
    # Final setup
    final_setup
    
    # Display notes
    display_notes
}

# Run main function
main "$@"
