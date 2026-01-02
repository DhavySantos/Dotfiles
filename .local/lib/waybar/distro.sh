#!/bin/bash

# Waybar distro identification script with Nerd Font icons

get_distro_info() {
    # Try to get distro name from various sources
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO_NAME="$NAME"
        DISTRO_ID="$ID"
        DISTRO_VERSION="$VERSION_ID"
        DISTRO_PRETTY="$PRETTY_NAME"
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        DISTRO_NAME="$DISTRIB_DESCRIPTION"
        DISTRO_ID="$DISTRIB_ID"
    else
        DISTRO_NAME=$(uname -s)
        DISTRO_ID="unknown"
    fi
}

get_distro_icon() {
    local distro_lower=$(echo "$DISTRO_ID" | tr '[:upper:]' '[:lower:]')
    local icon=""
    
    case $distro_lower in
        arch|archlinux)
            icon="󰣇"
            ;;
        manjaro)
            icon=""
            ;;
        endeavouros)
            icon=""
            ;;
        artix)
            icon="󰣇"
            ;;
        ubuntu)
            icon=""
            ;;
        debian)
            icon=""
            ;;
        fedora)
            icon=""
            ;;
        rhel|redhat)
            icon=""
            ;;
        centos)
            icon=""
            ;;
        opensuse*|suse)
            icon=""
            ;;
        gentoo)
            icon=""
            ;;
        alpine)
            icon=""
            ;;
        void)
            icon=""
            ;;
        nixos)
            icon=""
            ;;
        guix)
            icon=""
            ;;
        linuxmint|mint)
            icon="󰣭"
            ;;
        pop|pop_os|popos)
            icon=""
            ;;
        elementary)
            icon=""
            ;;
        zorin)
            icon=""
            ;;
        kali)
            icon=""
            ;;
        parrot)
            icon=""
            ;;
        solus)
            icon=""
            ;;
        slackware)
            icon=""
            ;;
        raspbian)
            icon=""
            ;;
        *bsd|freebsd)
            icon=""
            ;;
        openbsd)
            icon="󰈺"
            ;;
        macos|darwin)
            icon=""
            ;;
        windows)
            icon=""
            ;;
        *)
            icon=""
            ;;
    esac
    
    echo "$icon"
}

get_kernel_version() {
    uname -r
}

get_uptime() {
    local uptime_seconds=$(awk '{print int($1)}' /proc/uptime)
    local days=$((uptime_seconds / 86400))
    local hours=$(((uptime_seconds % 86400) / 3600))
    local minutes=$(((uptime_seconds % 3600) / 60))
    
    if [ $days -gt 0 ]; then
        echo "${days}d ${hours}h"
    elif [ $hours -gt 0 ]; then
        echo "${hours}h ${minutes}m"
    else
        echo "${minutes}m"
    fi
}

get_package_count() {
    local count=0
    
    # Check different package managers
    if command -v pacman &> /dev/null; then
        count=$(pacman -Qq 2>/dev/null | wc -l)
        echo "$count (pacman)"
        return
    elif command -v dpkg &> /dev/null; then
        count=$(dpkg -l 2>/dev/null | grep ^ii | wc -l)
        echo "$count (dpkg)"
        return
    elif command -v rpm &> /dev/null; then
        count=$(rpm -qa 2>/dev/null | wc -l)
        echo "$count (rpm)"
        return
    elif command -v flatpak &> /dev/null; then
        count=$(flatpak list 2>/dev/null | wc -l)
        echo "$count (flatpak)"
        return
    fi
    
    echo "N/A"
}

# Main execution
get_distro_info
icon="$(get_distro_icon)"

# Get system information
kernel=$(get_kernel_version)
uptime=$(get_uptime)
packages=$(get_package_count)
hostname=$(hostname)

# Build tooltip with system information
tooltip="╭─ System Information ─╮"
tooltip="$tooltip\n│"
tooltip="$tooltip\n│  Distro: $DISTRO_PRETTY"
tooltip="$tooltip\n│ 󰌽 Kernel: $kernel"
tooltip="$tooltip\n│  Host: $hostname"
tooltip="$tooltip\n│ 󰔟 Uptime: $uptime"
tooltip="$tooltip\n│ 󰏖 Packages: $packages"
tooltip="$tooltip\n│"
tooltip="$tooltip\n╰────────────────────╯"

# Handle click events
case $1 in
    "sysinfo")
        # Open system information (customize this command)
        if command -v neofetch &> /dev/null; then
            kitty -e neofetch &
        elif command -v fastfetch &> /dev/null; then
            kitty -e fastfetch &
        else
            notify-send "System Info" "$tooltip"
        fi
        ;;
    "update")
        # Trigger system update (customize for your distro)
        if command -v pacman &> /dev/null; then
            kitty -e sudo pacman -Syu &
        elif command -v apt &> /dev/null; then
            kitty -e sudo apt update && sudo apt upgrade &
        fi
        ;;
    *)
        # Default: output icon and info
        echo "{\"text\":\"$icon\", \"tooltip\":\"$tooltip\", \"class\":\"$DISTRO_ID\"}"
        ;;
esac
