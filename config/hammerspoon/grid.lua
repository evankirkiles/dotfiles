-- Grid
hs.grid.setGrid("6x2")
hs.grid.setMargins("0,0")

--- z: show grid
hs.hotkey.bind(HYPER, "z", function() hs.grid.show() end)

-- op[];' resize and move window in grid
hs.hotkey.bind(MASH, "p", function() hs.grid.set(hs.window.focusedWindow(), "0,0, 3x1") end)
hs.hotkey.bind(MASH, "o", function() hs.grid.set(hs.window.focusedWindow(), "0,2, 3x1") end)
hs.hotkey.bind(MASH, "[", function() hs.grid.set(hs.window.focusedWindow(), "3,0, 3x1") end)
hs.hotkey.bind(MASH, "]", function() hs.grid.set(hs.window.focusedWindow(), "3,2, 3x1") end)
hs.hotkey.bind(MASH, ";", function() hs.grid.set(hs.window.focusedWindow(), "0,0, 3x2") end)
hs.hotkey.bind(MASH, "'", function() hs.grid.set(hs.window.focusedWindow(), "3,0, 3x2") end)

--- /: move window to next screen
hs.hotkey.bind(MASH, "/", function()
	local win = hs.window.focusedWindow()
	local nextScreen = win:screen():next()
	win:moveToScreen(nextScreen)
end)
