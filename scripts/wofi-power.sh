#!/bin/bash

entries="🟡 Logout\n🟠 Suspend\n🟢 Reboot\n❌  Shutdown"

selected=$(echo -e $entries|wofi -x 1710 -y 15 --width 100 --height 210 --prompt Search --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

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
