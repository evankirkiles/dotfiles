local function toggleApplication(name)
	local app = hs.application.find(name)
	if not app or app:isHidden() then
		hs.application.launchOrFocus(name)
	elseif hs.application.frontmostApplication() ~= app then
		app:activate()
		-- else
		-- 	app:hide()
	end
end

-- Hammerspoon bindings for easily opening applications
hs.hotkey.bind(MASH, "u", function() toggleApplication("Messages") end)
hs.hotkey.bind(MASH, "i", function() toggleApplication("iTerm") end)
hs.hotkey.bind(MASH, "o", function() toggleApplication("Safari") end)
hs.hotkey.bind(MASH, "p", function() toggleApplication("System Preferences") end)
hs.hotkey.bind(MASH, "f", function() toggleApplication("Finder") end)
