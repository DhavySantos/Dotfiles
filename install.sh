# DOTFILES PACKAGES
sudo pacman -Sy --noconfirm \
	xclip maim rofi-wayland kitty \
	ttf-cascadia-code-nerd \
	xorg-xrandr neovim stow \
	kitty zsh starship zoxide \
	exa tmux feh picom rustup \
	libcanberra

# AMDGPU PACKAGES
sudo pacman -Sy --noconfirm \
	vulkan-radeon lib32-vulkan-radeon \
	mesa lib32-mesa xf86-video-amdgpu

# INSTALL YAY
git clone https://aur.archlinux.org/yay.git /tmp/yay
(cd /tmp/yay && makepkg -si --noconfirm)

mkdir -p $HOME/.config/{hypr,i3,rofi,tmux/plugins,waybar,kitty}

# CREATE .DOTFILES LINKS
stow --ignore=".(sh)$" .

# CLONE PLUGINS
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/autosuggestions
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/pluings/tpm

# SETUP RUST
rustup default stable
rustup component add rust-analyzer
