local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { '/bin/zsh', '-l', '-c', 'tmux attach || tmux' }
-- config.default_prog = { '/bin/zsh', '-l', '-c', 'zellij attach || zellij' }

config.font = wezterm.font {
    family = 'firacode nerd font',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}
config.font_size = 14
config.enable_tab_bar = false
config.color_scheme = 'GitHub Dark'
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
-- config.window_background_opacity = 0.75

return config
