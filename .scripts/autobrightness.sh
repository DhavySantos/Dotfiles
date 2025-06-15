#!/bin/bash

set -e  # Exit on error

set_brightness() {
    local brightness=$1
    for display in $(ddcutil detect | grep -oP 'Display \K\d+'); do
        echo "Setting brightness for display $display: ${brightness}%"
        ddcutil setvcp 10 "$brightness" --display="$display"
    done
}

set_temperature() {
    local temperature=$1
    echo "Setting color temperature to ${temperature}K"
    hyprctl hyprsunset temperature "$temperature"
}

# Get current time in hours and minutes
current_hour=$(date +%H)
current_minute=$(date +%M)

# Calculate total minutes from midnight
now_minutes=$((10#$current_hour * 60 + 10#$current_minute))

# Define key time boundaries in minutes
START_TIME=960    # 16:00 (4 PM)
END_TIME=1080     # 18:00 (6 PM)
MORNING_TIME=360  # 06:00 (6 AM)

# Define color temperatures (Kelvin)
TEMP_DAY=6500     # Daytime temperature
TEMP_NIGHT=3500   # Nighttime temperature

echo "Current time in minutes: $now_minutes"

if (( now_minutes >= MORNING_TIME && now_minutes < START_TIME )); then
    # Between 6 AM and 4 PM
    brightness=100
    temperature=$TEMP_DAY
elif (( now_minutes >= END_TIME )); then
    # After 6 PM
    brightness=0
    temperature=$TEMP_NIGHT
elif (( now_minutes >= START_TIME && now_minutes < END_TIME )); then
    # Between 4 PM and 6 PM
    total_interval=$((END_TIME - START_TIME))  # 120 minutes
    elapsed=$((now_minutes - START_TIME))

    # Linear interpolation
    brightness=$((100 - (elapsed * 100 / total_interval)))
    temp_diff=$((TEMP_DAY - TEMP_NIGHT))
    temperature=$((TEMP_DAY - (elapsed * temp_diff / total_interval)))
else
    # Before 6 AM
    brightness=0
    temperature=$TEMP_NIGHT
fi

set_temperature "$temperature"
set_brightness "$brightness"

