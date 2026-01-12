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

# choose video driver
echo "1) xf86-video-intel     2) vulkan-radeon     3) nvidia     4) Skip"
read -r -p "Choose your video card driver(default 1)(will not re-install): " vid

case $vid in
[1])
    DRI='xf86-video-intel'
    ;;

[2])
    DRI='vulkan-radeon lib32-vulkan-radeon'
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

# Making diretories
# echo "Creating diretories"
# sudo cp ./user-dirs.defaults /etc/xdg/;
xdg-user-dirs-update;
echo "DONE..."

# others apps and utilities
sudo pacman -S --noconfirm neovim foot alacritty $BRW fastfetch exa bat openrgb zathura zathura-pdf-mupdf imagemagick

# TOP Utilities

sudo pacman -S nvtop btop amdgpu_top

# Printscreen
sudo pacman -S grim slurp

# Bluetooth
sudo pacman -S bluez bluez-utils

# Gaming stuffs
sudo pacman -S mangohud mesa-utils

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

echo "Changing gtk theme, icons and cursors..."
sleep 1
sudo pacman -S gnome-themes-extra nwg-look
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
# gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
# papirus-folders -C yaru --theme Papirus-Dark
# gsettings set org.gnome.desktop.interface cursor-theme volantes_light_cursors
echo "DONE..."
sleep 1

# My Config

## Terminal
if [ -f ~/.config/foot/foot.ini ]; then
    echo "Foot files detected, backing up..."
    cp ~/.config/foot/foot.ini ~/.config/foot/foot.ini.old;
    cp ./foot/foot.ini ~/.config/foot/;
    echo "DONE"
else
    echo "Copying Foot files..."
    cp -r ./foot/ ~/.config/;
    echo "DONE"
fi

## Terminal
if [ -f ~/.config/alacritty/alacritty.toml ]; then
    echo "Alacritty files detected, backing up..."
    cp ~/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml.old;
    cp ./alacritty/alacritty.toml ~/.config/alacritty/;
    echo "DONE"
else
    echo "Copying Alacritty files..."
    cp -r ./alacritty/ ~/.config/;
    echo "DONE"
fi

## Text Editor
if [ -f ~/.config/nvim/init.lua ]; then
    echo "Neovim files detected, backing up..."
    cp ~/.config/nvim/init.lua ~/.config/nvim/init.lua.old;
    cp ./nvim/init.lua ~/.config/nvim/;
    echo "DONE"
else
    echo "Copying Neovim files..."
    cp -r ./nvim/ ~/.config/;
    echo "DONE"
fi

## Tiling Window Manager
if [ -f ~/.config/sway/config ]; then
    echo "Sway files detected, backing up..."
    cp ~/.config/sway/config ~/.config/sway/config.old;
    cp ./sway/config ~/.config/sway/;
    echo "DONE"
else
    echo "Copying Sway files..."
    cp -r ./sway/ ~/.config/;
    echo "DONE"
fi

## Waybar
if [ -f ~/.config/waybar/config ]; then
    echo "Waybar files detected, backing up..."
    cp ~/.config/waybar/config ~/.config/waybar/config.old;
    cp ~/.config/waybar/style.css ~/.config/waybar/style.css.old;
    cp ./waybar/config ~/.config/waybar/;
    cp ./waybar/style.css ~/.config/waybar/;
    echo "DONE"
else
    echo "Waybar files not found, copying..."
    cp -r ./waybar/ ~/.config/;
    echo "DONE"
fi

## Wofi
if [ -f ~/.config/wofi/config ]; then
    echo "Wofi files detected, backing up..."
    cp ~/.config/wofi/config ~/.config/wofi/config.old;
    cp ~/.config/wofi/style.css ~/.config/wofi/style.css.old;
    cp ./wofi/* ~/.config/wofi/;
    echo "DONE"
else
    echo "Wofi files not found, copying..."
    cp -r ./wofi/ ~/.config/;
    echo "DONE"
fi

## Screenlock
if [ -f ~/.config/swaylock/config ]; then
    echo "Swaylock files detected, backing up..."
    cp ~/.config/swaylock/config ~/.config/swaylock/config.old;
    cp ./swaylock/config ~/.config/swaylock/;
    echo "DONE"
else
    echo "Copying Swaylock files..."
    cp -r ./swaylock/ ~/.config/;
    echo "DONE"
fi

## Notification
if [ -f ~/.config/mako/config ]; then
    echo "Mako files detected, backing up..."
    cp ~/.config/mako/config ~/.config/mako/config.old;
    cp ./mako/config ~/.config/mako/;
    echo "DONE"
else
    echo "Copying Mako files..."
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

## Ranger
if [ -f ~/.config/ranger/rc.conf ]; then
    echo "Ranger files detected, backing up..."
    cp ~/.config/ranger/rc.conf ~/.config/ranger/rc.conf.old;
    cp ./ranger/rc.conf ~/.config/ranger/;
    echo "DONE"
else
    echo "Ranger files not found, installing..."
    cp -r ./ranger/ ~/.config/;
    echo "DONE"
fi


## PDF
if [ -f ~/.config/zathura/zathurarc ]; then
    echo "Zathura files detected, backing up..."
    cp ~/.config/zathura/zathurarc ~/.config/zathura/zathurarc.old;
    cp ./zathura/zathurarc ~/.config/zathura/;
    echo "DONE"
else
    echo "Zathura files not found, installing..."
    cp -r ./zathura/ ~/.config/;
    echo "DONE"
fi

## MangoHud
if [ -f ~/.config/MangoHud/MangoHud.conf ]; then
    echo "MangoHud files detected, backing up..."
    cp ~/.config/MangoHud/MangoHud.conf ~/.config/MangoHud.conf.old;
    cp ./MangoHud/MangoHud.conf ~/.config/MangoHud/;
    echo "DONE"
else
    echo "MangoHud files not found, installing..."
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
    cp -r ./scripts/ ~/scripts/;
    echo "DONE"
fi

echo "SUCCESS..."
