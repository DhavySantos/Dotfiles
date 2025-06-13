#!/bin/bash

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
END_TIME=1080     # 19:00 (7 PM)
MORNING_TIME=360  # 06:00 (6 AM)

# Define color temperatures (Kelvin)
TEMP_DAY=6500     # Daytime temperature
TEMP_NIGHT=3800   # Evening/warm temperature

if (( now_minutes == MORNING_TIME )); then
    # At 6 AM: reset to daytime settings
    set_temperature "$TEMP_DAY"
    set_brightness 100
    exit 0
fi

if (( now_minutes <= START_TIME )); then
    # Before 4 PM: full brightness and daytime temperature
    brightness=100
    set_temperature "$TEMP_DAY"
elif (( now_minutes >= END_TIME )); then
    # After 7 PM: brightness off and daytime temperature (adjust if needed)
    brightness=0
    set_temperature "$TEMP_NIGHT"
else
    # Between 4 PM and 7 PM: gradually decrease brightness and temperature
    total_interval=$((END_TIME - START_TIME))  # 120 minutes
    elapsed=$((now_minutes - START_TIME))

    # Linear interpolation for brightness (100 -> 0)
    brightness=$((100 - (elapsed * 100 / total_interval)))

    # Linear interpolation for temperature (6500K -> 4500K)
    temp_diff=$((TEMP_DAY - TEMP_NIGHT))
    temperature=$((TEMP_DAY - (elapsed * temp_diff / total_interval)))

    set_temperature "$temperature"
fi

set_brightness "$brightness"
