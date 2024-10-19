# DOTFILES PACKAGES
sudo pacman -Sy --noconfirm \
	xclip maim rofi kitty \
	xorg-xrandr neovim stow \
	ttf-cascadia-code-nerd \
	kitty zsh starship zoxide \
	exa tmux feh picom rustup \
	libcanberra

# AMDGPU PACKAGES
sudo pacman -Sy --noconfirm \
	vulkan-radeon lib32-vulkan-radeon \
	mesa lib32-mesa xf86-video-amdgpu

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/autosuggestions

# SETUP RUST
rustup default stable
rustup component add rust-analyzer

# CREATE .DOTFILES LINKS
stow --ignore=".(sh)$" .
