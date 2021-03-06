#!/bin/bash

entries="š” Logout\nš  Suspend\nš¢ Reboot\nā  Shutdown"

selected=$(echo -e $entries|wofi --width 100 --height 160 --prompt Power --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  logout)
    swaymsg exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
