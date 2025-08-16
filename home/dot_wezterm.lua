local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { '/bin/zsh', '-l', '-c', 'tmux attach || tmux' }

config.font = wezterm.font {
    family = 'jetbrainsmono nerd font',
    -- family = 'firacode nerd font',
    -- family = 'Iosevka Nerd Font',
    -- family = 'hack nerd font',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}
-- config.freetype_load_flags = 'NO_HINTING'
config.font_size = 14
config.enable_tab_bar = false

config.color_scheme = 'GitHub Dark'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
-- config.color_scheme = 'Gruvbox dark, pale (base16)'
-- config.color_scheme = 'GruvboxDarkHard'
-- config.color_scheme = 'Modus-Vivendi'
-- config.color_scheme = 'Solarized (dark) (terminal.sexy)'
-- config.color_scheme = 'Solarized Dark - Patched'
-- config.color_scheme = 'Gruber (base16)'

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.window_background_opacity = 0.9

return config
