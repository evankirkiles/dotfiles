-- Application mappings
local appMaps = {
	u = "Messages",
	i = "iTerm",
	o = "Safari",
	p = "System Preferences",
	f = "Figma",
}

-- Allow opening apps using above keybinds
for appKey, appName in pairs(appMaps) do
	hs.hotkey.bind(MASH, appKey, function() hs.application.launchOrFocus(appName) end)
end
