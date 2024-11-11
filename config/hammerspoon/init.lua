---init
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
spoon.SpoonInstall:andUse("Keychain")
spoon.SpoonInstall:andUse("EmmyLua")

-- This is the set of keys to run a hammerspoon command
mash = { "⌘", "⌥", "⌃" }

require("apps")
require("grid")

hs.hotkey.bind(mash, "r", hs.reload) -- [MASH+R] Reload Hammerspoon config
hs.hotkey.bind(mash, "c", hs.toggleConsole)
hs.hotkey.bind(mash, "a", hs.caffeinate.lockScreen) -- [MASH+A] Lock screen
hs.alert("Hammerspoon config loaded")
