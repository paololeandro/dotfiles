#!/bin/bash

# Get the brightness percentage:
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness);
BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/actual_brightness);
PCT=$(echo $BRIGHTNESS $MAX_BRIGHTNESS | awk '{printf "%4.0f",($1/$2)*100}')

# Round the brightness percentage:
LC_ALL=C

# Send the notification with the icon:
notify-send "Brightness ${PCT}%"
