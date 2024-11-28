#!/bin/bash
managers=("i3wm" "hyprland")

echo "Select your window manager:"

for index in "${!managers[@]}"; do
  echo "$((index + 1))) - ${managers[index]}"
done

read -p "Enter your choice: " choice

if ! [[ "$choice" =~ ^[0-9]+$ ]] || ((choice < 1 || choice > ${#managers[@]})); then
  echo "Invalid choice. Exiting."
  exit 1
fi

choice=${managers[choice - 1]}
packages="
  kitty ttf-cascadia-code-nerd stow 
  zsh starship zoxide fzf exa tmux
  rustup yazi neovim google-chrome
  curl git lazygit
"

if [ $choice == "i3wm" ]; then
  packages+=" xclip i3-wm polybar rofi lightdm feh lightdm-gtk-greeter xremap-x11-bin"
fi

if [ $choice == "hyprland" ]; then
  packages+=" wl-clipboard hyprland hyprpaper hyprshot waybar rofi-wayland sddm xremap-wlroots-bin"
fi

yay -Sy --noconfirm $packages
echo "Packages installed."

# Install the Gruvbox theme if not already installed
if ! [ -d "$HOME/.themes/Gruvbox-Dark" ]; then 
  mkdir -p "$HOME/.themes"
  git clone https://github.com/vinceliuice/Colloid-gtk-theme /tmp/gruvbox-dark
  (cd /tmp/gruvbox-dark && ./install.sh -t default -c dark -s standard -n Gruvbox)
  rm -rf /tmp/gruvbox-dark
  echo "Gruvbox theme installed."
fi

# Install macOS-White cursor if not already installed
if ! [ -d "$HOME/.icons/macOS-White" ]; then 
  mkdir -p "$HOME/.icons"
  curl --output /tmp/macOS-White.tar.xz https://github.com/ful1e5/apple_cursor/releases/download/v2.0.1/macOS-White.tar.xz
  tar -xvf /tmp/macOS-White.tar.xz -C "$HOME/.icons"
  rm -f /tmp/macOS-White.tar.xz
  echo "macOS-White cursor installed."
fi

# Install yay if not already installed
if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg --si --noconfirm)
  rm -rf /tmp/yay
  echo "yay installed."
fi

stow -d ./"$choice" -t "$HOME" .
stow -d ./common -t "$HOME" .

echo "Script completed."

