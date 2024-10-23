local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- config.colors = {
-- 	-- 	background = "#1c2b36",
-- 	-- 	foreground = "#ffc9dd",
-- 	cursor_bg = "#ed79a3",
-- 	cursor_border = "#ffc9dd",
-- 	cursor_fg = "#ffffff",
-- 	-- 	selection_bg = "#ffe894",
-- 	-- 	selection_fg = "#1c2b36",
-- 	ansi = { "#1c2b36", "#ed7979", "#6fffd4", "#edd479", "#3d9fed", "#ed79a3", "#79d0ed", "#c9c9c9" },
-- 	brights = { "#384447", "#ffc9c9", "#b9fffc", "#fff3c9", "#8cd9ff", "#ffc9dd", "#c9f1ff", "#ffffff" },
-- }
--
config.font = wezterm.font("NotoMono Nerd Font Mono")
config.font_size = 18

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.6
config.macos_window_background_blur = 80
config.default_prog = { "/bin/zsh", "-l", "-c", "~/.config/tmux-start.sh; exec zsh" }

config.color_scheme = "Catppuccin Latte"

return config
