#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo pacman -Syu --noconfirm \
	zoxide zsh kitty tmux git neovim stow \
	starship hyprland xdg-desktop-portal-hyprland \
	wl-clipboard hyprshot hyprpaper rofi-wayland \
	waybar btop yazi adw-gtk-theme

if ! command -v yay &> /dev/null; then
	git clone https://aur.archlinux.org/yay /tmp/yay
	(cd /tmp/yay && makepkg -si --noconfirm)
fi

stow -d $SCRIPT_DIR -t $HOME .
