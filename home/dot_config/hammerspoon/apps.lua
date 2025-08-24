-- Application mappings
local appMaps = {
	u = "Messages",
	i = "Kitty",
	o = "Safari",
	p = "Slack",
	f = "Figma",
}

-- Allow opening apps using above keybinds
for appKey, appName in pairs(appMaps) do
	hs.hotkey.bind(MASH, appKey, function() hs.application.launchOrFocus(appName) end)
end

-- Allow focus switching between non-overlapping apps
hs.hotkey.bind(MASH, "h", function() hs.window.focusedWindow():focusWindowWest(nil, true, true) end)
hs.hotkey.bind(MASH, "j", function() hs.window.focusedWindow():focusWindowSouth(nil, true, true) end)
hs.hotkey.bind(MASH, "k", function() hs.window.focusedWindow():focusWindowNorth(nil, true, true) end)
hs.hotkey.bind(MASH, "l", function() hs.window.focusedWindow():focusWindowEast(nil, true, true) end)
