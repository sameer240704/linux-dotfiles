-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 11
config.line_height = 1.1

config.enable_tab_bar = false

config.window_decorations = "NONE"

config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
 }

config.window_background_opacity = 0.85
config.text_background_opacity = 0.9
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}

-- Cursor Styles
config.default_cursor_style = "SteadyUnderline"
-- config.cursor_blink_rate = 800

-- Scrollbar Styles
config.enable_scroll_bar = false

-- Window Size and Positioning
config.adjust_window_size_when_changing_font_size = false
config.initial_cols = 185
config.initial_rows = 47

-- Miscellaneous Stuff

config.max_fps = 144
config.prefer_egl = true

return config
