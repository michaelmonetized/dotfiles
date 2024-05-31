-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.colors = {
  background = "#142128",
  foreground = "#ffbdd5",
    cursor_bg = "#ed79a3",
	cursor_border = "#ed79a3",
	cursor_fg = "#ffedf4",
	selection_bg = "#c9f1ff",
	selection_fg = "#edfbff",
	ansi = { "#2d3d4d", "#ed7979", "#44FFB1", "#edd479", "#57baed", "#ed79a3", "#79d0ed", "#fafafa" },
	brights = { "#6d7d8d", "#fe8a8a", "#8afee1", "#fee58a", "#8ae1fe", "#ffc9dd", "#c9f1ff", "#ffffff" },
}

config.font = wezterm.font("NotoMono Nerd Font Mono")
config.font_size = 16

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 1
config.initial_cols = 83
config.initial_rows = 107

-- and finally, return the configuration to wezterm
return config