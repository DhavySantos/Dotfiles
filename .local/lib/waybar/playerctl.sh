#!/bin/bash

# Waybar playerctl media control script with enhanced visuals

get_status() {
    playerctl status 2>/dev/null
}

get_player() {
    playerctl -l 2>/dev/null | head -n 1
}

get_metadata() {
    local artist=$(playerctl metadata artist 2>/dev/null)
    local title=$(playerctl metadata title 2>/dev/null)
    local album=$(playerctl metadata album 2>/dev/null)
    local status=$(get_status)
    local player=$(playerctl metadata --format "{{playerName}}" 2>/dev/null)
    
    # Get position and length for progress bar
    local position=$(playerctl position 2>/dev/null | cut -d'.' -f1)
    local length=$(playerctl metadata mpris:length 2>/dev/null)
    
    # Get volume (0.0 to 1.0)
    local volume=$(playerctl volume 2>/dev/null)
    local volume_percent=$(printf "%.0f" $(echo "$volume * 100" | bc 2>/dev/null || echo "0"))
    
    # Format time
    format_time() {
        local seconds=$1
        printf "%d:%02d" $((seconds / 60)) $((seconds % 60))
    }
    
    # Set icon based on status and player
    case $status in
        "Playing")
            icon="󰎆"
            ;;
        "Paused")
            icon="󰏤"
            ;;
        *)
            icon="󰝛"
            ;;
    esac
    
    # Player-specific icons (optional enhancement)
    case $player in
        "spotify"|"Spotify")
            player_icon=""
            ;;
        "firefox"|"Firefox")
            player_icon="󰈹"
            ;;
        "chrome"|"chromium")
            player_icon=""
            ;;
        "mpv")
            player_icon=""
            ;;
        "vlc")
            player_icon="󰕼"
            ;;
        *)
            player_icon="󰝚"
            ;;
    esac
    
    # Truncate long text with ellipsis
    local max_length=35
    local display_text=""
    
    if [[ -n "$artist" && -n "$title" ]]; then
        display_text="$artist  $title"
    elif [[ -n "$title" ]]; then
        display_text="$title"
    fi
    
    if [ ${#display_text} -gt $max_length ]; then
        display_text="${display_text:0:$max_length}…"
    fi
    
    # Build tooltip with more information
    local tooltip="$player_icon $player"
    if [[ -n "$artist" && -n "$title" ]]; then
        tooltip="$tooltip\n♫ $title\n♪ $artist"
        if [[ -n "$album" ]]; then
            tooltip="$tooltip\n💿 $album"
        fi
    elif [[ -n "$title" ]]; then
        tooltip="$tooltip\n♫ $title"
    fi
    
    # Add playback time if available
    if [[ -n "$position" && -n "$length" ]]; then
        length_sec=$((length / 1000000))
        if [ $length_sec -gt 0 ]; then
            local pos_formatted=$(format_time $position)
            local len_formatted=$(format_time $length_sec)
            tooltip="$tooltip\n⏱ $pos_formatted / $len_formatted"
        fi
    fi
    
    # Add volume indicator with bar
    if [[ -n "$volume_percent" ]]; then
        local vol_icon
        if [ $volume_percent -eq 0 ]; then
            vol_icon="󰖁"
        elif [ $volume_percent -lt 30 ]; then
            vol_icon="󰕿"
        elif [ $volume_percent -lt 70 ]; then
            vol_icon="󰖀"
        else
            vol_icon="󰕾"
        fi
        
        # Create volume bar
        local bar_length=10
        local filled=$(( (volume_percent * bar_length) / 100 ))
        local empty=$(( bar_length - filled ))
        local vol_bar=$(printf '█%.0s' $(seq 1 $filled))$(printf '░%.0s' $(seq 1 $empty))
        
        tooltip="$tooltip\n$vol_icon $vol_bar $volume_percent%"
    fi
    
    # Return JSON with enhanced formatting
    if [[ -n "$display_text" ]]; then
        echo "{\"text\":\"$icon  $display_text\", \"tooltip\":\"$tooltip\", \"class\":\"$status\", \"alt\":\"$status\"}"
    else
        echo "{\"text\":\"󰝛  No media\", \"tooltip\":\"No media playing\", \"class\":\"stopped\", \"alt\":\"stopped\"}"
    fi
}

# Handle click events
case $1 in
    "play-pause")
        playerctl play-pause
        ;;
    "next")
        playerctl next
        ;;
    "previous")
        playerctl previous
        ;;
    "stop")
        playerctl stop
        ;;
    "volume-up")
        playerctl volume 0.05+
        ;;
    "volume-down")
        playerctl volume 0.05-
        ;;
    "volume-mute")
        # Toggle mute by setting volume to 0 or restoring
        current_vol=$(playerctl volume 2>/dev/null)
        if (( $(echo "$current_vol > 0" | bc -l) )); then
            echo "$current_vol" > /tmp/playerctl_last_volume
            playerctl volume 0
        else
            last_vol=$(cat /tmp/playerctl_last_volume 2>/dev/null || echo "0.5")
            playerctl volume "$last_vol"
        fi
        ;;
    *)
        # Default: output current status
        if [ -z "$(get_player)" ]; then
            echo "{\"text\":\"󰝛  No players\", \"tooltip\":\"No players found\", \"class\":\"stopped\", \"alt\":\"stopped\"}"
        else
            get_metadata
        fi
        ;;
esac
