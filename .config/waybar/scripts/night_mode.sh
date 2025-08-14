#!/bin/bash

TEMPERATURE=$(hyprctl hyprsunset temperature)
MONITORS=$(ddcutil detect | grep -c "^Display ")

if (( TEMPERATURE != 6000 )); then
	TARGET_TEMP=6000
	BRIGHTNESS=100
	echo " "
else
	TARGET_TEMP=2500
	BRIGHTNESS=10
	echo " "
fi

if [[ $1 == "toggle" ]]; then
	for MONITOR_INDEX in $(seq 1 "$MONITORS"); do
		ddcutil setvcp 10 "$BRIGHTNESS" --display "$MONITOR_INDEX"
	done

	hyprctl hyprsunset temperature "$TARGET_TEMP" > /dev/null 2>&1
fi
