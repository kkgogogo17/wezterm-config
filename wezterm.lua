--pull in the wezterm api
local wezterm = require("wezterm")
local config = {}
-- this will hold the configuration
-- local config = wezterm.config_builder()
local mux = wezterm.mux

-- maxmimize the window right away
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maxmimize()
end)

-- Import our new module (put this near the top of your wezterm.lua)
local appearance = require("appearance")

-- Use it!
-- if appearance.is_dark() then
config.color_scheme = "Mariana"
-- else
-- 	config.color_scheme = "Tokyo Night Day"
-- end

--this is where you actually apply your config choices
-- font size
config.font_size = 15
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
-- for example, changing the colorscheme
-- config.color_scheme = "Github Light (Gogh)"
-- config.color_scheme = "mariana"
config.colors = {
	cursor_bg = "#61afef",
	cursor_fg = "Black",
	cursor_border = "#61afef",
}
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 800

config.adjust_window_size_when_changing_font_size = false

-- Leader is the same as my old tmux prefix
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- splitting
	{
		mods = "LEADER",
		key = "f",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "d",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- navigating
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- rotate panes
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- show the pane selection mode, but have it swap the active and selected panes
	{
		mods = "LEADER",
		key = "0",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
}

-- remove padding around
config.window_padding = {
	left = "0",
	right = "0",
	top = "0",
	bottom = "0",
}

config.window_decorations = "RESIZE"

wezterm.on("update-status", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if string.find(pane:get_title(), "^n-vi-m-.*") then
		overrides.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
	else
		overrides.window_padding = config.window_padding
	end
	window:set_config_overrides(overrides)
end)

config.window_background_opacity = 1
config.macos_window_background_blur = 50

-- and finally, return the configuration to wezterm
return config
