#!/bin/bash
set -e 

echo "Welcome!" && sleep 2

# default vars
HELPER="yay"

# does full system update
echo "Doing a system update, cause stuff may brake if it's not the latest version..."
sudo pacman --noconfirm -Syu

echo "###########################################################################"
echo "Will do stuff, get ready"
echo "###########################################################################"

# install base-devel if not installed
sudo pacman -S --noconfirm --needed base-devel git

# choose video driver
echo "1) xf86-video-intel     2) xf86-video-amd-gpu     3) nvidia     4) Skip"
read -r -p "Choose your video card driver(default 1)(will not re-install): " vid

case $vid in
[1])
    DRI='xf86-video-intel'
    ;;

[2])
    DRI='xf86-video-amd-gpu'
    ;;

[3])
    DRI='nvidia nvidia-settings nvidia-utils'
    ;;

[4])
    DRI=""
    ;;
    
[*])
    DRI='xf86-video-intel'
    ;;
esac

# choose browser
echo "1) firefox    2) chromium   3) Skip"
read -r -p "Choose your browser(default 1)(will not re-install): " brwsr

case $brwsr in
[1])
    BRW='firefox'
    ;;

[2])
    BRW='chromium'
    ;;

[3])
    BRW=""
    ;;

[*])
    BRW='firefox'
    ;;
esac

# install wayland and some x-wayland stuffs if not installed
sudo pacman -S --noconfirm --needed $DRI xorg-xwayland sway waybar swayidle swaylock bemenu-wayland mako libnotify 

# install audio stuffs if not installed
sudo pacman -S --noconfirm mpv bluez bluez-utils blueman pavucontrol pipewire pipewire-alsa pipewire-pulse pipewire-jack pipewire-media-session alsa-firmware sof-firmware alsa-ucm-conf pamixer playerctl brightnessctl

# screen sharing stuffs
sudo pacman -S --noconfirm xdg-desktop-portal xdg-desktop-portal-wlr

# others apps and utilities
sudo pacman -S --noconfirm alacritty neofetch nautilus unzip file-roller gnome-disk-utility ntfs-3g zathura zathura-pdf-mupdf transmission-gtk

# development stuffs
sudo pacman -S --noconfirm yarn npm

# install fonts
mkdir -p ~/.local/share/fonts
mkdir -p ~/.helper

cp -r ./fonts/* ~/.local/share/fonts/
fc-cache -f
clear

echo "We need an AUR helper. 1) yay   2) paru"
read -r -p "What is the AUR helper of your choice? (Default is yay): " num

if [ $num -eq 2 ]
    then
        HELPER="paru"
fi

if ! command -v $HELPER &> /dev/null
    then
        echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing..."
            git clone https://aur.archlinux.org/$HELPER.git ~/.helper/$HELPER
            ( cd ~/.helper/$HELPER/ && makepkg -si )
fi

# install stuffs with AUR helper
$HELPER -S asdf-vm                 \ 
           spotify                 \
           papirus-icon-theme-git  \
           papirus-folders-git

# custom config files
if [ -f ~/.config/alacritty/alacritty.yml ]; then
    echo "Alacritty configs detected, backing up..."
    cp ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.old;
    cp ./alacritty/alacritty.yml ~/.config/alacritty/;
    cp ~/.config/alacritty/paradise.yml ~/.config/alacritty/paradise.yml.old;
    cp ./alacritty/paradise.yml ~/.config/alacritty/;
else
    echo "Installing alacritty configs..."
    cp -r ./alacritty/ ~/.config/;
fi
if [ -d ~/wallpapers ]; then
    echo "Adding wallpapers to ~/wallpapers..."
    cp ./wallpapers/* ~/wallpapers/;
else
    echo "Installing wallpapers..."
    mkdir ~/wallpapers && cp -r ./wallpapers/* ~/wallpapers/;
fi
if [ -f ~/.config/mako/config ]; then
    echo "Mako configs detected, backing up..."
    cp ~/.config/mako/config ~/.config/mako/config.old;
    cp ./mako/config ~/.config/mako/;
else
    echo "Installing mako configs..."
    cp -r ./mako/ ~/.config/;
fi
if [ -f ~/.config/sway/config ]; then
    echo "Sway configs detected, backing up..."
    cp ~/.config/sway/config ~/.config/sway/config.old;
    cp ./sway/config ~/.config/sway/;
else
    echo "Installing sway configs..."
    cp -r ./sway/ ~/.config/;
fi
if [ -f ~/.config/swaylock/config ]; then
    echo "Swaylock configs detected, backing up..."
    cp ~/.config/swaylock/config ~/.config/swaylock/config.old;
    cp ./swaylock/config ~/.config/swaylock/;
else
    echo "Installing swaylock configs..."
    cp -r ./swaylock/ ~/.config/;
fi
if [ -f ~/.config/waybar/config ]; then
    echo "Waybar configs detected, backing up..."
    cp ~/.config/waybar/config ~/.config/waybar/config.old;
    cp ~/.config/waybar/style.css ~/.config/waybar/style.css.old;
    cp ./waybar/config ~/.config/waybar/;
    cp ./waybar/style.css ~/.config/waybar/;
else
    echo "Waybar configs not found, installing..."
    cp -r ./waybar/ ~/.config/;
fi
if [ -f ~/.config/zathura/zathurarc ]; then
    echo "Zathura configs detected, backing up..."
    cp ~/.config/zathura/zathurarc ~/.config/zathura/zathurarc.old;
    cp ~/.config/zathura/paradise.yml ~/.config/zathura/paradise.yml.old;
    cp ./zathura/zathurarc ~/.config/zathura/;
    cp ./zathura/paradise.yml ~/.config/zathura/;
else
    echo "Zathura configs not found, installing..."
    cp -r ./zathura/ ~/.config/;
fi
