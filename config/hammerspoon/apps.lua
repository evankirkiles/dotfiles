local function toggleApplication(name)
	local app = hs.application.find(name)
	if not app or app:isHidden() then
		hs.application.launchOrFocus(name)
	elseif hs.application.frontmostApplication() ~= app then
		app:activate()
	else
		app:hide()
	end
end

-- Hammerspoon bindings for easily opening applications
hs.hotkey.bind(mash, "u", function() toggleApplication("Safari") end)
hs.hotkey.bind(mash, "i", function() toggleApplication("Messages") end)
hs.hotkey.bind(mash, "o", function() toggleApplication("iTerm") end)
hs.hotkey.bind(mash, "f", function() toggleApplication("Finder") end)
hs.hotkey.bind(mash, "p", function() toggleApplication("System Preferences") end)
