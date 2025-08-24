#!/bin/bash

LANGUAGES=(en)
LOCALE="en_US@currency=USD"
SCREENSHOTS_FOLDER="${HOME}/Screenshots"

# Topics
#
# - Computer & Host name
# - Localization
# - System
# - Keyboard & Input
# - Trackpad, mouse, Bluetooth accessories
# - Screen
# - Finder
# - Dock
# - Mail
# - Calendar
# - Terminal
# - Activity Monitor
# - Software Updates

osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# ====== LOGIN ITEMS ===============

# Add these items to open on login
LOGIN_ITEMS=("Hammerspoon" "Karabiner-Elements" "Shottr")
for ITEM in "${LOGIN_ITEMS[@]}"; do
  PROPERTIES="{ name: \"$ITEM\", path:\"/Applications/$ITEM.app\", hidden:false }"
  osascript -e "tell application \"System Events\" to make login item at end with properties $PROPERTIES"
done

# ========== LOCALIZATION ==============
# Using systemsetup might give Error:-99, can be ignored (commands still work)
# systemsetup manpage: https://ss64.com/osx/systemsetup.html

# Set the time zone
sudo defaults write /Library/Preferences/com.apple.timezone.auto Active -bool YES
sudo systemsetup -setusingnetworktime on

# ========== SYSTEM ==============

sudo systemsetup -setrestartfreeze on 2>/dev/null # Restart automatically if the computer freezes
sudo pmset -a standbydelay 86400                  # Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a sms 0                               # Disable Sudden Motion Sensor

# Sound
defaults write com.apple.sound.beep.feedback -bool false # Disable audio feedback when volume is changed

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Printing
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true # Automatically quit printer app once the print jobs complete

# Crash Reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Global stuff, localization, input, etc.
defaults write NSGlobalDomain AppleLanguages -array "${LANGUAGES[@]}"         # Set language as configured above
defaults write NSGlobalDomain AppleLocale -string "$LOCALE"                   # Set text locale as above
defaults write NSGlobalDomain AppleFontSmoothing -int 2                       # Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3                      # Enable full keyboard access for all controls
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false            # Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain KeyRepeat -int 1                                # Set fast key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15                        # Key repeat starts quickly too
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false   # Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false  # Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # Disable smart quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false  # Disable smart dashes

# Macbook Keyboard / BezelServices
defaults write com.apple.BezelServices kDim -bool true   # Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDimTime -int 300 # Turn off keyboard illumination when computer is not used for 5 minutes

# Bluetooth Audio
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40 # Increase sound quality for Bluetooth headphones/headsets

# Screenshots
mkdir -p "${SCREENSHOTS_FOLDER}"
defaults write com.apple.screencapture location -string "${SCREENSHOTS_FOLDER}" # Save screenshots to the ~/Screenshots folder
defaults write com.apple.screencapture type -string "png"                       # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture disable-shadow -bool true                # Disable shadow in screenshots

# Finder
defaults write com.apple.finder QuitMenuItem -bool true                                                                # allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder DisableAllAnimations -bool true                                                        # disable window animations and Get Info animations
defaults write com.apple.finder AppleShowAllFiles -bool true                                                           # show hidden files by default
defaults write com.apple.finder ShowStatusBar -bool true                                                               # show status bar
defaults write com.apple.finder ShowPathbar -bool true                                                                 # show path bar
defaults write com.apple.finder QLEnableTextSelection -bool true                                                       # allow text selection in quick look
defaults write com.apple.finder _FXSortFoldersFirst -bool true                                                         # keep folders on top when sorting by name
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"                                                    # when performing a search, search current folder by default
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false                                             # disable the warning when changing a file extension
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"                                                    # always open everything in Finder's list view
defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true # expand these file info panes

# Desktop Services
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true # don't create DS_Store on network drives
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true     # don't create DS_Store on USB drives

# Network Browser
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true # use AirDrop over every interfaceFXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true

# Dock
defaults write com.apple.dock show-process-indicators -bool true # show indicator lights for open applications in dock
defaults write com.apple.dock launchanim -bool false             # don't animate opening applications from the dock
defaults write com.apple.dock autohide -bool true                # automatically hide and show the dock
defaults write com.apple.dock showhidden -bool true              # make dock icons of hidden applications translucent
defaults write com.apple.dock no-bouncing -bool true             # no bouncing icons
defaults write com.apple.dock show-recents -bool false           # don't show recently used applications in the Dock

# Disable hot corners
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0

# Use XDG_CONFIG_HOME for: ITerm, HammerSpoon
defaults write org.hammerspoon.Hammerspoon MJConfigFile "${XDG_CONFIG_HOME}/hammerspoon/init.lua"

# Kill the affected applications to make their changes take effect
for app in "Address Book" "Calendar" "Contacts" "Dock" "Finder" "Mail" "Safari" "SystemUIServer" "iCal"; do
  killall "${app}" &>/dev/null
done
