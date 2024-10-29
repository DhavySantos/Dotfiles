#!/bin/bash

# Initialize the last state variable to track performance level
last_state="low"

# Infinite loop with a sleep interval of 5 seconds
while true; do
  # Check for the presence of a gamescope window
  if hyprctl clients | grep "class: gamescope" > /dev/null; then
    # If gamescope is detected, check if the last state is not high
    if [ "$last_state" != "high" ]; then
      echo "Gamescope detected. Changing performance level to high."
      sudo /opt/rocm/bin/rocm-smi --setperflevel high
      last_state="high"  # Update the last state to high
    fi
  else
    # If gamescope is not detected, check if the last state is not low
    if [ "$last_state" != "low" ]; then
      echo "No gamescope detected. Changing performance level to low."
      sudo /opt/rocm/bin/rocm-smi --setperflevel low
      last_state="low"  # Update the last state to low
    fi
  fi
  # Wait for 5 seconds before checking again
  sleep 5
done

