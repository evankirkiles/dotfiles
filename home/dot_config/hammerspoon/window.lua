-- Settings
hs.window.animationDuration = 0
---Apply a grid setting to all windows of the specified app
---@param appName string
---@param gridSettings string
local function adjustWindowsOfApp(appName, gridSettings)
	local app = hs.application.get(appName)
	local wins
	if app then wins = app:allWindows() end
	if wins then
		for _, win in ipairs(wins) do
			hs.grid.set(win, gridSettings)
		end
	end
end

---Focus an application if it is launched
---@param appName string
local function focusIfLaunched(appName)
	local app = hs.application.get(appName)
	if app then app:activate() end
end

---Helper function for defining a layout of applications
---@param name string
---@param key string | integer
---@param layout any
local function defineLayout(name, key, layout, smallLayout)
	hs.hotkey.bind(MASH, key, function()
		hs.alert.show("Layout: " .. name)
		local targetLayout = layout
		if smallLayout and hs.screen.mainScreen():frame().w <= 2000 then targetLayout = smallLayout end
		for _, app in ipairs(targetLayout) do
			adjustWindowsOfApp(app[1], app[2])
			if app[3] then focusIfLaunched(app[1]) end
		end
	end)
end

--- FLOWS

--- Split screen coding layout
defineLayout("Code", "return", {
	{ "Safari", "4,0 2x4", true }, -- Right half
	{ "Kitty", "0,0 4x4", true }, -- Left half
}, { -- Small layout
	{ "Safari", "0,0 6x4", true },
	{ "Kitty", "0,0 6x4", true },
})

--- Full screen Figma design layout
defineLayout("Design", "]", {
	{ "Figma", "0,0, 6x4", true },
})

--- Pops Messages up on top of the screen
defineLayout("Messaging", "\\", {
	{ "Messages", "2,1, 2x2", true },
})
