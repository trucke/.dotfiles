#!/usr/bin/env bash
# https://privacy.sexy — v0.12.10 — Mon, 19 Feb 2024 19:36:16 GMT
if [ "$EUID" -ne 0 ]; then
    script_path=$([[ "$0" = /* ]] && echo "$0" || echo "$PWD/${0#./}")
    sudo "$script_path" || (
        echo 'Administrator privileges are required.'
        exit 1
    )
    exit 0
fi


# ----------------------------------------------------------
# ------------Disable remote management service-------------
# ----------------------------------------------------------
echo '--- Disable remote management service'
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop
# ----------------------------------------------------------


# ----------------------------------------------------------
# -----------Remove Apple Remote Desktop Settings-----------
# ----------------------------------------------------------
echo '--- Remove Apple Remote Desktop Settings'
sudo rm -rf /var/db/RemoteManagement
sudo defaults delete /Library/Preferences/com.apple.RemoteDesktop.plist
defaults delete ~/Library/Preferences/com.apple.RemoteDesktop.plist
sudo rm -rf /Library/Application\ Support/Apple/Remote\ Desktop/
rm -r ~/Library/Application\ Support/Remote\ Desktop/
rm -r ~/Library/Containers/com.apple.RemoteDesktop
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------------Disable "Ask Siri"--------------------
# ----------------------------------------------------------
echo '--- Disable "Ask Siri"'
defaults write com.apple.assistant.support 'Assistant Enabled' -bool false
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Disable Siri voice feedback----------------
# ----------------------------------------------------------
echo '--- Disable Siri voice feedback'
defaults write com.apple.assistant.backedup 'Use device speaker for TTS' -int 3
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------Disable Siri services (Siri and assistantd)--------
# ----------------------------------------------------------
echo '--- Disable Siri services (Siri and assistantd)'
launchctl disable "user/$UID/com.apple.assistantd"
launchctl disable "gui/$UID/com.apple.assistantd"
sudo launchctl disable 'system/com.apple.assistantd'
launchctl disable "user/$UID/com.apple.Siri.agent"
launchctl disable "gui/$UID/com.apple.Siri.agent"
sudo launchctl disable 'system/com.apple.Siri.agent'
if [ $(/usr/bin/csrutil status | awk '/status/ {print $5}' | sed 's/\.$//') = "enabled" ]; then
    >&2 echo 'This script requires SIP to be disabled. Read more: https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection'
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------Disable "Do you want to enable Siri?" pop-up-------
# ----------------------------------------------------------
echo '--- Disable "Do you want to enable Siri?" pop-up'
defaults write com.apple.SetupAssistant 'DidSeeSiriSetup' -bool True
# ----------------------------------------------------------


# ----------------------------------------------------------
# ----------------Remove Siri from menu bar-----------------
# ----------------------------------------------------------
echo '--- Remove Siri from menu bar'
defaults write com.apple.systemuiserver 'NSStatusItem Visible Siri' 0
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Remove Siri from status menu---------------
# ----------------------------------------------------------
echo '--- Remove Siri from status menu'
defaults write com.apple.Siri 'StatusMenuVisible' -bool false
defaults write com.apple.Siri 'UserHasDeclinedEnable' -bool true
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------Disable participation in Siri data collection-------
# ----------------------------------------------------------
echo '--- Disable participation in Siri data collection'
defaults write com.apple.assistant.support 'Siri Data Sharing Opt-In Status' -int 2
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------------Disable online spell correction--------------
# ----------------------------------------------------------
echo '--- Disable online spell correction'
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Disable remote Apple events----------------
# ----------------------------------------------------------
echo '--- Disable remote Apple events'
sudo systemsetup -setremoteappleevents off
# ----------------------------------------------------------


# ----------------------------------------------------------
# --Disable automatic storage of documents in iCloud Drive--
# ----------------------------------------------------------
echo '--- Disable automatic storage of documents in iCloud Drive'
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------Disable display of recent applications on Dock------
# ----------------------------------------------------------
echo '--- Disable display of recent applications on Dock'
defaults write com.apple.dock show-recents -bool false
# ----------------------------------------------------------


# ----------------------------------------------------------
# ----------------Disable Spotlight indexing----------------
# ----------------------------------------------------------
echo '--- Disable Spotlight indexing'
sudo mdutil -i off -d /
# ----------------------------------------------------------


# Disable personalized advertisements and identifier tracking
echo '--- Disable personalized advertisements and identifier tracking'
defaults write com.apple.AdLib allowIdentifierForAdvertising -bool false
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.AdLib forceLimitAdTracking -bool true
# ----------------------------------------------------------


# ----------------------------------------------------------
# -----Disable automatic installation of macOS updates------
# ----------------------------------------------------------
echo '--- Disable automatic installation of macOS updates'
# For OS X Yosemite through macOS High Sierra (>= 10.10 && < 10.14)
sudo defaults write /Library/Preferences/com.apple.commerce 'AutoUpdateRestartRequired' -bool false
# For Mojave and newer (>= 10.14)
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate 'AutomaticallyInstallMacOSUpdates' -bool false
# ----------------------------------------------------------


# Enable password requirement for waking from sleep or screen saver
echo '--- Enable password requirement for waking from sleep or screen saver'
sudo defaults write /Library/Preferences/com.apple.screensaver askForPassword -bool true
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------Disable guest sign-in from login screen----------
# ----------------------------------------------------------
echo '--- Disable guest sign-in from login screen'
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------Disable guest access to file shares over AF--------
# ----------------------------------------------------------
echo '--- Disable guest access to file shares over AF'
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------Disable guest access to file shares over SMB-------
# ----------------------------------------------------------
echo '--- Disable guest access to file shares over SMB'
sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------------Disable insecure telnet protocol-------------
# ----------------------------------------------------------
echo '--- Disable insecure telnet protocol'
sudo launchctl disable system/com.apple.telnetd
# ----------------------------------------------------------


# ----------------------------------------------------------
# ----------Disable Bonjour multicast advertising-----------
# ----------------------------------------------------------
echo '--- Disable Bonjour multicast advertising'
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------------Disable the insecure TFTP service-------------
# ----------------------------------------------------------
echo '--- Disable the insecure TFTP service'
sudo launchctl disable 'system/com.apple.tftpd'
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------------------Clear Homebrew cache-------------------
# ----------------------------------------------------------
echo '--- Clear Homebrew cache'
if type "brew" &>/dev/null; then
    brew cleanup -s &>/dev/null
    rm -rfv $(brew --cache) &>/dev/null
    brew tap --repair &>/dev/null
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Clear CUPS printer job cache---------------
# ----------------------------------------------------------
echo '--- Clear CUPS printer job cache'
sudo rm -rfv /var/spool/cups/c0*
sudo rm -rfv /var/spool/cups/tmp/*
sudo rm -rfv /var/spool/cups/cache/job.cache*
# ----------------------------------------------------------


# ----------------------------------------------------------
# ----------------Empty trash on all volumes----------------
# ----------------------------------------------------------
echo '--- Empty trash on all volumes'
# on all mounted volumes
sudo rm -rfv /Volumes/*/.Trashes/* &>/dev/null
# on main HDD
sudo rm -rfv ~/.Trash/* &>/dev/null
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------------Clear system cache--------------------
# ----------------------------------------------------------
echo '--- Clear system cache'
sudo rm -rfv /Library/Caches/* &>/dev/null
sudo rm -rfv /System/Library/Caches/* &>/dev/null
sudo rm -rfv ~/Library/Caches/* &>/dev/null
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------------Clear DNS cache----------------------
# ----------------------------------------------------------
echo '--- Clear DNS cache'
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------------------Clear inactive memory-------------------
# ----------------------------------------------------------
echo '--- Clear inactive memory'
sudo purge
# ----------------------------------------------------------


echo 'Your privacy and security is now hardened 🎉💪'
echo 'Press any key to exit.'
read -n 1 -s