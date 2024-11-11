hs.grid.setGrid("2x2")
hs.grid.setMargins("0,0")
hs.window.animationDuration = 0

local function getWin() return hs.window.focusedWindow() end
local function setGrid(grid)
	hs.grid.setGrid(grid)
	hs.alert.show(string.format("Grid set to %s", grid))
end

--- hjkl: move window
hs.hotkey.bind(mash, "h", function() hs.grid.pushWindowLeft() end)
hs.hotkey.bind(mash, "l", function() hs.grid.pushWindowRight() end)
hs.hotkey.bind(mash, "k", function() hs.grid.pushWindowUp() end)
hs.hotkey.bind(mash, "j", function() hs.grid.pushWindowDown() end)

--- Arrows: resize window
hs.hotkey.bind(mash, "left", function() hs.grid.resizeWindowThinner() end)
hs.hotkey.bind(mash, "down", function() hs.grid.resizeWindowShorter() end)
hs.hotkey.bind(mash, "up", function() hs.grid.resizeWindowTaller() end)
hs.hotkey.bind(mash, "right", function() hs.grid.resizeWindowWider() end)

--- 234: resize grid
hs.hotkey.bind(mash, "2", function() setGrid("2x2") end)
hs.hotkey.bind(mash, "3", function() setGrid("3x3") end)
hs.hotkey.bind(mash, "4", function() setGrid("4x4") end)

--- /: move window to next screen
hs.hotkey.bind(mash, "/", function()
	local win = getWin()
	win:moveToScreen(win:screen():next())
end)

--- ,: snap window to grid
hs.hotkey.bind(mash, ",", function() hs.grid.snap(getWin()) end)

--- space: maximize window
hs.hotkey.bind(mash, "space", function() hs.grid.maximizeWindow() end)
--- .: minimize window
hs.hotkey.bind(mash, ".", function() hs.grid.set(getWin(), "0,0 1x1") end)
