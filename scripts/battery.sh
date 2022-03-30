#!/bin/bash
# Low battery notifier

# Kill already running processes
already_running="$(ps -fC 'grep' -N | grep 'battery.sh' | wc -l)"
if [[ $already_running -gt 1 ]]; then
	pkill -f --older 1 'battery.sh'
fi

# Get path
path="$( dirname "$(readlink -f "$0")" )"

while [[ 0 -eq 0 ]]; do
	battery_status="$(cat /sys/class/power_supply/BAT0/status)"
	battery_charge="$(cat /sys/class/power_supply/BAT0/capacity)"

	if [[ $battery_status == 'Discharging' && $battery_charge -le 30 ]]; then
		if   [[ $battery_charge -le 15 ]]; then
	  	notify-send --icon="$HOME/.git/dotfiles/icons/low-battery.png" --urgency=critical "Battery critical!" "${battery_charge}%"
			sleep 180
		elif [[ $battery_charge -le 20 ]]; then
			notify-send --icon="$HOME/.git/dotfiles/icons/low-battery.png" --urgency=critical "Battery critical!" "${battery_charge}%"
			sleep 240
		else
			notify-send --icon="$HOME/.git/dotfiles/icons/low-battery.png" "Battery low!" "${battery_charge}%"
			sleep 360
		fi
		sleep 600
	fi

	if [[ $battery_status == 'Charging' && $battery_charge > 95 ]]; then
	  	notify-send --icon="$path/icons/full-battery.png" --urgency=critical "Battery full!" "${battery_charge}%"
			sleep 180
    else
      sleep 600
  fi
done

