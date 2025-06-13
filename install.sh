#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo pacman -Syu --noconfirm \
	zoxide zsh kitty tmux git neovim stow \
	starship hyprland xdg-desktop-portal-hyprland \
	wl-clipboard hyprshot hyprpaper rofi-wayland \
	waybar btop yazi adw-gtk-theme

stow -d $SCRIPT_DIR -t $HOME .
