#!/bin/bash

entries="🟡 Logout\n🟠 Suspend\n🟢 Reboot\n❌  Shutdown"

selected=$(echo -e $entries|wofi --width 100 --height 200 --prompt Power --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  logout)
    swaymsg exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec loginctl poweroff;;
esac
