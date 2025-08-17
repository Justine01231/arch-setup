# 🐧 My Arch Linux Setup Guide

A complete guide to quickly restore my Arch Linux environment after a fresh installation.

## 🚀 Quick Setup

```bash
# Clone this repository
git clone https://github.com/yourusername/arch-setup.git
cd arch-setup

# Make setup script executable
chmod +x setup.sh

# Run the setup script
./setup.sh
```

## 📋 What This Setup Includes

- **Kitty Terminal** with Dracula theme
- **JetBrains Mono Nerd Font** and other essential fonts
- **Enhanced Bashrc** with funny aliases (`fucking firefox`, etc.)
- **Fastfetch** with custom configuration for system info
- **Essential packages** for development and daily use
- **Dotfiles configuration**
- **AUR helper** (yay) installation

## 🛠️ Manual Installation Steps

If you prefer to install step by step:

### 1. Install Essential Packages

```bash
# Update system
sudo pacman -Syu

# Install essential packages
sudo pacman -S --needed \
  kitty \
  git \
  curl \
  wget \
  vim \
  neovim \
  base-devel \
  fontconfig \
  fastfetch \
  ttf-jetbrains-mono-nerd \
  ttf-firacode-nerd \
  ttf-cascadia-code-nerd \
  ttf-hack-nerd \
  ttf-sourcecodepro-nerd
```

### 2. Install AUR Helper (yay)

```bash
# Clone yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd .. && rm -rf yay
```

### 3. Configure Terminal and Shell

```bash
# Create config directories
mkdir -p ~/.config/kitty
mkdir -p ~/.config/fastfetch

# Copy configurations
cp kitty/kitty.conf ~/.config/kitty/
cp dotfiles/bashrc ~/.bashrc
cp dotfiles/fastfetch.jsonc ~/.config/fastfetch/config.jsonc

# Refresh font cache
fc-cache -fv
```

### 4. Additional Development Tools (Optional)

```bash
# Programming languages and tools
sudo pacman -S --needed \
  python \
  python-pip \
  nodejs \
  npm \
  rust \
  go \
  docker \
  docker-compose

# Enable Docker service
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

## 📁 Repository Structure

```
arch-setup/
├── README.md                 # This guide
├── setup.sh                  # Automated setup script
├── kitty/
│   └── kitty.conf            # Kitty terminal configuration
├── dotfiles/
│   ├── bashrc                # Enhanced bashrc with funny aliases
│   └── fastfetch.jsonc       # Fastfetch system info configuration
├── packages/
│   ├── essential.txt         # Essential packages list
│   ├── development.txt       # Development packages list
│   └── aur.txt              # AUR packages list
└── scripts/
    ├── install-fonts.sh     # Font installation script
    ├── install-aur.sh       # AUR helper installation
    └── post-install.sh      # Post-installation tasks
```

## ⚡ Quick Commands Reference

### Kitty Terminal Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+Enter` | New window |
| `Ctrl+Shift+Q` | Close tab |
| `Ctrl+Shift+W` | Close window |
| `Ctrl+Shift+L` | Next layout |
| `Ctrl+Shift+A>M` | Increase transparency |
| `Ctrl+Shift+A>L` | Decrease transparency |
| `F11` | Toggle fullscreen |

### Package Management

```bash
# Update system
sudo pacman -Syu

# Install package
sudo pacman -S package_name

# Search package
pacman -Ss search_term

# Remove package
sudo pacman -R package_name

# Clean package cache
sudo pacman -Sc
```

### AUR with yay

```bash
# Install AUR package
yay -S package_name

# Update AUR packages
yay -Sua

# Search AUR
yay -Ss search_term
```

## 🎨 Customization

### Change Kitty Theme

The current setup uses Dracula theme. To change:

1. Edit `~/.config/kitty/kitty.conf`
2. Modify the color scheme section
3. Restart Kitty or press `Ctrl+Shift+F2` to reload config

### Font Changes

Available Nerd Fonts installed:
- JetBrains Mono Nerd Font (default)
- Fira Code Nerd Font
- Cascadia Code Nerd Font
- Hack Nerd Font
- Source Code Pro Nerd Font

To change font, edit `font_family` in kitty.conf.

## 🔧 Troubleshooting

### Font Issues
```bash
# Refresh font cache
fc-cache -fv

# List available fonts
fc-list | grep -i nerd
```

### Kitty Not Loading Config
```bash
# Check config syntax
kitty --debug-config

# Reset to default config
mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.backup
```

### Permission Issues
```bash
# Fix ownership of home directory
sudo chown -R $USER:$USER ~/

# Fix permissions
chmod 755 ~/.config/kitty/
chmod 644 ~/.config/kitty/kitty.conf
```

## 📝 Notes

- This setup is tested on Arch Linux with KDE/GNOME/i3
- Make sure to update the repository after making changes
- Backup your current configs before running the setup script
- The setup script will create backups of existing configurations

## 🤝 Contributing

Feel free to fork this repository and customize it for your needs!

---

**Last updated**: $(date +'%Y-%m-%d')
**Arch Linux Version**: Rolling Release
**Kitty Version**: Latest from official repos
