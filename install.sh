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
  curl git lazygit spotify
"

if [ $choice == "i3wm" ]; then
  packages+="
    xclip i3-wm polybar rofi
    lightdm feh picom lightdm-gtk-greeter
    xremap-x11-bin xdg-desktop-portal-gtk
  "
fi

if [ $choice == "hyprland" ]; then
  packages+="
    wl-clipboard hyprland hyprpaper 
    hyprshot waybar rofi-wayland sddm 
    xremap-wlroots-bin xdg-desktop-portal-hyprland
  "
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

if ! [ -d $HOME/.ohmyzsh ]; then
  git cloen https://github.com/ohmyzsh/ohmyzsh $HOME/.ohmyzsh
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.ohmyzsh/custom/plugins/syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.ohmyzsh/custom/plugins/autosuggestions
  git clone https://github.com/zsh-users/zsh-completions $HOME/.ohmyzsh/custom/plugins/zsh-completions
fi

if ! [ -d $HOME/Pictures ]; then
  mkdir -p $HOME/Pictures
  curl -o $HOME/Pictures/wallpaper.jpg https://i.imgur.com/4lqHk7C.jpeg
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

