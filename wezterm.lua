--Pull in the wezterm API
local wezterm = require("wezterm")
local config = {}
-- This will hold the configuration
-- local config = wezterm.config_builder()
local mux = wezterm.mux
local act = wezterm.action
local Catppuccin = require("./theme/Catppuccin")
local everforest = require("./theme/everforest")

-- Maxmimize the window right away
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maxmimize()
end)

--This is where you actually apply your config choices
-- font size
config.font_size = 16
config.font = wezterm.font("JetBrains Mono")

-- For example, changing the colorscheme
-- config.color_scheme = "Catppuccin Frappe"
config.colors = everforest.colors
config.adjust_window_size_when_changing_font_size = false

config.keys = {
	{ key = "l", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "CMD", action = act.ActivatePaneDirection("Right") },
	{ key = "h", mods = "CMD", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CMD", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CMD", action = act.ActivatePaneDirection("Up") },
	{ key = "f", mods = "CMD", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
}

config.window_background_opacity = 0.9
config.macos_window_background_blur = 50

-- and finally, return the configuration to wezterm
return config
