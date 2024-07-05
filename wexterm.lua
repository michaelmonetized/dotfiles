-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.colors = {
  background = "#1c2b36",
  foreground = "#ffc9dd",
    cursor_bg = "#ed79a3",
	cursor_border = "#ffc9dd",
	cursor_fg = "#ffffff",
	selection_bg = "#ffe894",
	selection_fg = "#1c2b36",
	ansi =    { "#1c2b36", "#ed7979", "#6fffd4", "#edd479", "#3d9fed", "#ed79a3", "#79d0ed", "#c9c9c9" },
	brights = { "#384447", "#ffc9c9", "#b9fffc", "#fff3c9", "#8cd9ff", "#ffc9dd", "#c9f1ff", "#ffffff" },
}

config.font = wezterm.font("NotoMono Nerd Font Mono")
config.font_size = 16

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 0
config.initial_cols = 102
config.initial_rows = 56
config.default_prog = { '/bin/zsh', '-l', '-c', '~/.config/tmux-start.sh; exec zsh' }

-- and finally, return the configuration to wezterm
return config
