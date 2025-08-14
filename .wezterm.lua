local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.font = wezterm.font "CaskaydiaCove Nerd Font"
config.font_size = 10

config.front_end = "WebGpu"
config.enable_wayland = false
config.enable_tab_bar = false
config.default_prog = { "/usr/bin/zsh" }
config.color_scheme = 'Gruvbox dark, hard (base16)'
config.colors = { background = "#181818" }

return config
