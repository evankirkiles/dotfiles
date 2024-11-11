---init
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
spoon.SpoonInstall:andUse("Keychain")
spoon.SpoonInstall:andUse("EmmyLua")

HYPER = { "cmd", "alt", "ctrl", "shift" }
MASH = { "cmd", "alt", "ctrl" }

require("apps")
require("grid")
require("window")

hs.hotkey.bind(MASH, "r", hs.reload) -- [MASH+R] Reload Hammerspoon config
hs.hotkey.bind(MASH, "c", hs.toggleConsole)
hs.hotkey.bind(MASH, "a", hs.caffeinate.lockScreen) -- [MASH+A] Lock screen

--- Alert the reloading of Hammerspoon
hs.alert("Hammerspoon config loaded")
