#!/bin/sh

# Toggle hyprsunset (Hyprland blue light filter)
# Usage: ./toggle-hyprsunset.sh [temperature]

TEMP="${1:-3200}"  # Default temperature: 4000K

# Get current temperature value
CURRENT=$(hyprctl hyprsunset temperature 2>/dev/null)

# Check if it's at 6500K (identity/disabled) or something else (enabled)
if [ "$CURRENT" = "6500" ]; then
    # Filter is disabled (identity = 6500K), enable it
    hyprctl hyprsunset temperature "$TEMP"
    echo "hyprsunset enabled at ${TEMP}K"
else
    # Filter is active, disable it
    hyprctl hyprsunset temperature 6500
    echo "hyprsunset disabled (6500K)"
fi
