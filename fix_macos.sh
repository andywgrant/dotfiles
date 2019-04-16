#!/bin/sh
# Run this script as a regular user.

# Don't show me a splash screen
sudo nvram boot-args="-v"

# Don't hide things
defaults write com.apple.Finder AppleShowAllFiles TRUE
defaults write com.apple.Finder ShowPathbar -bool true
defaults write com.apple.Finder _FXShowPosixPathInTitle -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Don't ask stupid questions
#defaults write com.apple.Finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Don't do the stupid workspace reordering thing
defaults write com.apple.dock mru-spaces -bool false

# ANIMATE FASTER
defaults write com.apple.dock expose-animation-duration -float 0.15

# Use autohide but make it quick
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.17
# On second thought, let's make it fast to animate but hard to trigger
defaults write com.apple.dock autohide-delay -int 2

# Kill dashboard
defaults write com.apple.dock "dashboard-in-overlay" -bool true

# Remove all dock icons
defaults write com.apple.dock persistent-apps -array

# Allow keyboard navigation for modals
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ANIMATE MORE FASTER
defaults write NSGlobalDomain NSWindowResizeTime .1

# By default, you can't type things like "GAAAAAAAAAAAH".
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fastest key repeat. Still too slow.
defaults write NSGlobalDomain KeyRepeat -int 1

# This is not an iPad.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Do not ask me if I'm sure. I am always sure.
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Do not leave crap all over my network shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Time machine is great, but I don't need this prompt
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable drop shadow on screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Disable stupid semitransparent menubar
# This is probably counterproductive with dark mode
# defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# I do not need my documents to be cloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Check for updates daily.
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable candy colors
defaults write -g AppleAquaColorVariant -int 6;

# Turn on firewall, such as it is
sudo defaults write /Library/Preferences/com.apple.sharing.firewall state -bool YES

# Ask for password after lock
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Show icons for hard drives, servers, and removable media on the desktop
#defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
#defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
#defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
#defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# DARK MODE
sudo defaults write /Library/Preferences/.GlobalPreferences AppleInterfaceTheme Dark

# Enable HiDPI display modes
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Expand print and save panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Give basic info on login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Don't pop up the photos app when stuff gets plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Disable sketchy spotlight options, I really only use it to launch apps
defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 0;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 0;"name" = "DIRECTORIES";}' \
    '{"enabled" = 0;"name" = "PDF";}' \
    '{"enabled" = 0;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "SOURCE";}' \
    '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 0;"name" = "MENU_OTHER";}' \
    '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
    '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Disable Time Machine icon
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
done

# It's my library. Let me see it.
chflags nohidden ~/Library/
sudo chflags nohidden /tmp
sudo chflags nohidden /usr

# Kill parentalcontrolsd
sudo rm -rf "/Library/Application Support/Apple/ParentalControls"


# Relaunch with new settings
killall Dock
killall Finder

# Stop DHCP from twiddling names
#scutil --set HostName local.foo.bar

# Disable "safe sleep", saving 8-16G of disk space. Doing so is basically no
# less secure than the default behavior when it comes to cold boot attacks, as
# Safe Sleep leaves the RAM powered for 24 hours anyway. You'd have to hibernate
# every time you close the machine to prevent that. If you want to do that, use
# this:
#
# sudo pmset -a destroyfvkeyonstandby 1 hibernatemode 25 autopoweroff 0
#
# You can also use autopoweroff and reduce the autopoweroffdelay if you want
# to sleep -> hibernate after a period of time.
#
# Or you can do this to save space.
# pmset -a hibernatemode 0
# pmset -a autopoweroff 0
# rm /private/var/vm/sleepimage
# sudo touch /private/var/vm/sleepimage
# sudo chflags uchg /private/var/vm/sleepimage

sudo pmset -a standbydelay 300 
sudo pmset -a standby 0 
sudo pmset -a halfdim 1 
sudo pmset -a powernap 0 
sudo pmset -a gpusiwtch 2 
sudo pmset -a disksleep 0 
sudo pmset -a sleep 90 
sudo pmset -a autopoweroffdelay 0 
sudo pmset -a hibernatemode 25 
sudo pmset -a autopoweroff 0 
sudo pmset -a ttyskeepawake 1 
sudo pmset -a displaysleep 60 
sudo pmset -a acwake 0 
sudo pmset -a lidwake 1

# Copy settings

read -p "Preparing to copy settings"

for file in .zshrc .prompt .vimrc .vim
do
    cp -r ~/dotfiles/$file ~/$file
done

# Install things
read -p "Preparing to install apps"

# Brews

sudo xcodebuild -license
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install cscope nmap python3 zsh rg coreutils colordiff exiftool
brew install flawfinder fswatch hashcat rats wdiff the_silver_searcher
brew install vim --with-override-system-vi --with-lua --with-python3
brew install ctags --HEAD

# Install casks
read -p "Preparing to install casks"
brew install caskroom/cask/brew-cask
brew tap buo/cask-upgrade
brew tap caskroom/fonts
brew cask install font-inconsolata
brew cask install font-source-code-pro
brew cask install iterm2
brew cask install spectacle
brew cask install karabiner-elements
brew cask install wireshark
brew cask install macvim
