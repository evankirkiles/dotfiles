-- Grid
hs.grid.setGrid("6x4")
hs.grid.setMargins("0,0")

--- z: show grid
hs.hotkey.bind(HYPER, "z", function() hs.grid.show() end)

-- op[];' resize and move window in grid
-- hs.hotkey.bind(MASH, "p", function() hs.grid.set(hs.window.focusedWindow(), "0,0, 3x2") end)
-- hs.hotkey.bind(MASH, "o", function() hs.grid.set(hs.window.focusedWindow(), "0,2, 3x2") end)
-- hs.hotkey.bind(MASH, "[", function() hs.grid.set(hs.window.focusedWindow(), "3,0, 3x2") end)
-- hs.hotkey.bind(MASH, "]", function() hs.grid.set(hs.window.focusedWindow(), "3,2, 3x2") end)
-- hs.hotkey.bind(MASH, ";", function() hs.grid.set(hs.window.focusedWindow(), "0,0, 3x4") end)
-- hs.hotkey.bind(MASH, "'", function() hs.grid.set(hs.window.focusedWindow(), "3,0, 3x4") end)

--- /: move window to next screen
hs.hotkey.bind(MASH, "/", function()
	local win = hs.window.focusedWindow()
	local nextScreen = win:screen():next()
	win:moveToScreen(nextScreen)
end)

--- space: maximize window
hs.hotkey.bind(MASH, "space", function() hs.grid.maximizeWindow() end)
--- ,: minimize window
hs.hotkey.bind(MASH, ",", function() hs.grid.set(hs.window.focusedWindow(), "2,1 2x2") end)
