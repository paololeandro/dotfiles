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
sudo pacman -S --noconfirm --needed base-devel

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

# install audio stuffs if not installed
sudo pacman -S --noconfirm mpv pavucontrol

xdg-user-dirs-update;

sudo systemctl enable --now cups

echo "Changing gtk theme, icons and cursors..."
sleep 1
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
# gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
# papirus-folders -C yaru --theme Papirus-Dark
# gsettings set org.gnome.desktop.interface cursor-theme volantes_light_cursors
echo "DONE..."
sleep 1
