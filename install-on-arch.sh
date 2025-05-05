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
echo "1) xf86-video-intel     2) vulkan-radeon     3) nvidia     4) Skip"
read -r -p "Choose your video card driver(default 1)(will not re-install): " vid

case $vid in
[1])
    DRI='xf86-video-intel'
    ;;

[2])
    DRI='vulkan-radeon'
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
sudo pacman -S --noconfirm --needed $DRI xorg-xwayland sway waybar swayidle swaylock swaybg mako wofi libnotify 

# install audio stuffs if not installed
sudo pacman -S --noconfirm mpv pavucontrol

# xdg stuffs
sudo pacman -S --noconfirm xdg-desktop-portal-wlr xdg-user-dirs
xdg-user-dirs-update;

# others apps and utilities
sudo pacman -S --noconfirm neovim foot $BRW neofetch exa bat zathura zathura-pdf-mupdf imagemagick

# Printscreen
sudo pacman -S grim slurp

# Bluetooth
sudo pacman -S bluez bluez-utils

# Gaming stuffs
sudo pacman -S mangohud mesa-utils

# development stuffs
# sudo pacman -S npm yarn rust

# auto mount android 4+ devices
# sudo pacman -S mtpfs gvfs-mtp gvfs-gphoto2

# zsh stuffs
sudo pacman -S --noconfirm zsh zsh-autosuggestions zsh-syntax-highlighting

echo "Changing shell to ZSH"
cp ./.zshrc ~/.zshrc;
chsh -s /bin/zsh;
sleep 1
echo "DONE..."

# install fonts
echo "Installing fonts..."
mkdir -p ~/.local/share/fonts/;
cp -r ./fonts/* ~/.local/share/fonts/;
fc-cache -f
clear
echo "Fonts installed..."

echo "Creating AUR helper directory"
mkdir -p ~/.helper

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
$HELPER -S ranger-git

echo "Changing gtk theme, icons and cursors..."
sleep 1
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
papirus-folders -C yaru --theme Papirus-Dark
gsettings set org.gnome.desktop.interface cursor-theme volantes_light_cursors
echo "DONE..."
sleep 1

# My Config
## Terminal
if [ -f ~/.config/foot/foot.ini ]; then
    echo "Foot configs detected, backing up..."
    cp ~/.config/foot/foot.ini ~/.config/foot/foot.ini.old;
    cp ./foot/foot.ini ~/.config/foot/;
    echo "DONE"
else
    echo "Installing Foot configs..."
    cp -r ./foot/ ~/.config/;
    echo "DONE"
fi
## Text Editor
if [ -f ~/.config/nvim/init.lua ]; then
    echo "Neovim configs detected, backing up..."
    cp ~/.config/nvim/init.lua ~/.config/nvim/init.lua.old;
    cp ./nvim/init.lua ~/.config/nvim/;
    echo "DONE"
else
    echo "Installing Neovim configs..."
    cp -r ./nvim/ ~/.config/;
    echo "DONE"
fi

## Tiling Window Manager
if [ -f ~/.config/sway/config ]; then
    echo "Sway configs detected, backing up..."
    cp ~/.config/sway/config ~/.config/sway/config.old;
    cp ./sway/config ~/.config/sway/;
    echo "DONE"
else
    echo "Installing sway configs..."
    cp -r ./sway/ ~/.config/;
    echo "DONE"
fi
## Waybar
if [ -f ~/.config/waybar/config ]; then
    echo "Waybar configs detected, backing up..."
    cp ~/.config/waybar/config ~/.config/waybar/config.old;
    cp ~/.config/waybar/style.css ~/.config/waybar/style.css.old;
    cp ./waybar/config ~/.config/waybar/;
    cp ./waybar/style.css ~/.config/waybar/;
    echo "DONE"
else
    echo "Waybar configs not found, installing..."
    cp -r ./waybar/ ~/.config/;
    echo "DONE"
fi
## Screenlock
if [ -f ~/.config/swaylock/config ]; then
    echo "Swaylock configs detected, backing up..."
    cp ~/.config/swaylock/config ~/.config/swaylock/config.old;
    cp ./swaylock/config ~/.config/swaylock/;
    echo "DONE"
else
    echo "Installing swaylock configs..."
    cp -r ./swaylock/ ~/.config/;
    echo "DONE"
fi
## Notification
if [ -f ~/.config/mako/config ]; then
    echo "Mako configs detected, backing up..."
    cp ~/.config/mako/config ~/.config/mako/config.old;
    cp ./mako/config ~/.config/mako/;
    echo "DONE"
else
    echo "Installing mako configs..."
    cp -r ./mako/ ~/.config/;
    echo "DONE"
fi
## Wallpapers
if [ -d ~/wallpapers ]; then
    echo "Adding wallpapers to ~/wallpapers..."
    cp ./wallpapers/* ~/wallpapers/;
    echo "DONE"
else
    echo "Installing wallpapers..."
    mkdir ~/wallpapers && cp -r ./wallpapers/* ~/wallpapers/;
    echo "DONE"
fi
## PDF
if [ -f ~/.config/zathura/zathurarc ]; then
    echo "Zathura configs detected, backing up..."
    cp ~/.config/zathura/zathurarc ~/.config/zathura/zathurarc.old;
    cp ./zathura/zathurarc ~/.config/zathura/;
    echo "DONE"
else
    echo "Zathura configs not found, installing..."
    cp -r ./zathura/ ~/.config/;
    echo "DONE"
fi
## MangoHud
if [ -f ~/.config/MangoHud/MangoHud.conf ]; then
    echo "MangoHud configs detected, backing up..."
    cp ~/.config/MangoHud/MangoHud.conf ~/.config/MangoHud.conf.old;
    cp ./MangoHud/MangoHud.conf ~/.config/MangoHud/;
    echo "DONE"
else
    echo "MangoHud configs not found, installing..."
    cp -r ./MangoHud/ ~/.config/;
    echo "DONE"
fi

## Scripts
if [ -d ~/scripts ]; then
    echo "Adding scripts do ~/scripts"   
    cp ./scripts/* ~/scripts/;
    echo "DONE"
else
    echo "Installing scripts..."
    cp -r ./scripts/* ~/;
    echo "DONE"
fi

echo "SUCCESS..."
