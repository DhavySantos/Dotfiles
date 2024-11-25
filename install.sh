# DOTFILES PACKAGES
sudo pacman -Sy --noconfirm \
	xclip maim rofi-wayland kitty \
	ttf-cascadia-code-nerd \
	xorg-xrandr neovim stow \
	kitty zsh starship zoxide \
	exa tmux feh picom rustup \
	libcanberra yazi hyprpaper

# AMDGPU PACKAGES
sudo pacman -Sy --noconfirm \
	vulkan-radeon lib32-vulkan-radeon \
	mesa lib32-mesa xf86-video-amdgpu

# INSTALL YAY
git clone https://aur.archlinux.org/yay.git /tmp/yay
(cd /tmp/yay && makepkg -si --noconfirm)

# YAY PACKAGES
yay -S --noconfirm \
  apple_cursor gruvbox-material-gtk-theme
  xremap-wlroots-bin hyprshoot

mkdir -p $HOME/.config/{hypr,i3,rofi,tmux/plugins,waybar,kitty} $HOME/Pictures $HOME/.scripts
curl -o $HOME/Pictures/wallpaper.jpg https://i.imgur.com/4lqHk7C.jpeg

# CREATE .DOTFILES LINKS
stow --ignore=".(sh)$" .

# CLONE PLUGINS
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/plugins/syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/plugins/autosuggestions

# SETUP RUST
rustup default stable
rustup component add rust-analyzer
