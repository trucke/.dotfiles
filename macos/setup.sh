#!/usr/bin/env bash
# https://privacy.sexy — v0.13.4 — Fri, 21 Jun 2024 08:32:01 GMT
if [ "$EUID" -ne 0 ]; then
    script_path=$([[ "$0" = /* ]] && echo "$0" || echo "$PWD/${0#./}")
    sudo "$script_path" || (
        echo 'Administrator privileges are required.'
        exit 1
    )
    exit 0
fi


# ----------------------------------------------------------
# ---------Disable Homebrew user behavior analytics---------
# ----------------------------------------------------------
echo '--- Disable Homebrew user behavior analytics'
command='export HOMEBREW_NO_ANALYTICS=1'
declare -a profile_files=("$HOME/.bash_profile" "$HOME/.zprofile")
for profile_file in "${profile_files[@]}"
do
    touch "$profile_file"
    if ! grep -q "$command" "${profile_file}"; then
        echo "$command" >> "$profile_file"
        echo "[$profile_file] Configured"
    else
        echo "[$profile_file] No need for any action, already configured"
    fi
done
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------Disable NET Core CLI telemetry--------------
# ----------------------------------------------------------
echo '--- Disable NET Core CLI telemetry'
command='export DOTNET_CLI_TELEMETRY_OPTOUT=1'
declare -a profile_files=("$HOME/.bash_profile" "$HOME/.zprofile")
for profile_file in "${profile_files[@]}"
do
    touch "$profile_file"
    if ! grep -q "$command" "${profile_file}"; then
        echo "$command" >> "$profile_file"
        echo "[$profile_file] Configured"
    else
        echo "[$profile_file] No need for any action, already configured"
    fi
done
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
# ------------Disable the insecure TFTP service-------------
# ----------------------------------------------------------
echo '--- Disable the insecure TFTP service'
sudo launchctl disable 'system/com.apple.tftpd'
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------------Disable insecure telnet protocol-------------
# ----------------------------------------------------------
echo '--- Disable insecure telnet protocol'
sudo launchctl disable system/com.apple.telnetd
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------Disable incoming SSH and SFTP remote logins--------
# ----------------------------------------------------------
echo '--- Disable incoming SSH and SFTP remote logins'
echo 'yes' | sudo systemsetup -setremotelogin off
# ----------------------------------------------------------


# ----------------------------------------------------------
# ----------Disable Bonjour multicast advertising-----------
# ----------------------------------------------------------
echo '--- Disable Bonjour multicast advertising'
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
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


# ----------------------------------------------------------
# ---------Disable macOS beta release installation----------
# ----------------------------------------------------------
echo '--- Disable macOS beta release installation'
# For OS X Yosemite and newer (>= 10.10)
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate 'AllowPreReleaseInstallation' -bool false
# ----------------------------------------------------------


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
# --------------------Clear bash history--------------------
# ----------------------------------------------------------
echo '--- Clear bash history'
rm -f ~/.bash_history
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------------Clear zsh history---------------------
# ----------------------------------------------------------
echo '--- Clear zsh history'
rm -f ~/.zsh_history
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------------------Clear diagnostics logs------------------
# ----------------------------------------------------------
echo '--- Clear diagnostics logs'
sudo rm -rfv /private/var/db/diagnostics/*
sudo rm -rfv /var/db/diagnostics/*
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------------Clear shared cache strings data--------------
# ----------------------------------------------------------
echo '--- Clear shared cache strings data'
sudo rm -rfv /private/var/db/uuidtext/
sudo rm -rfv /var/db/uuidtext/
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------Clear Apple System Logs (ASL)---------------
# ----------------------------------------------------------
echo '--- Clear Apple System Logs (ASL)'
sudo rm -rfv /private/var/log/asl/*
sudo rm -rfv /var/log/asl/*
sudo rm -fv /var/log/asl.log # Legacy ASL (10.4)
sudo rm -fv /var/log/asl.db
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------------Clear install logs--------------------
# ----------------------------------------------------------
echo '--- Clear install logs'
sudo rm -fv /var/log/install.log
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------Clear all system logs in `/var/log/` directory------
# ----------------------------------------------------------
echo '--- Clear all system logs in `/var/log/` directory'
sudo rm -rfv /var/log/*
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------Clear system application logs---------------
# ----------------------------------------------------------
echo '--- Clear system application logs'
sudo rm -rfv /Library/Logs/*
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------------Clear Mail logs----------------------
# ----------------------------------------------------------
echo '--- Clear Mail logs'
rm -rfv ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/*
# ----------------------------------------------------------


# Clear user activity audit logs (login, logout, authentication, etc.)
echo '--- Clear user activity audit logs (login, logout, authentication, etc.)'
sudo rm -rfv /var/audit/*
sudo rm -rfv /private/var/audit/*
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------------------Clear user report logs------------------
# ----------------------------------------------------------
echo '--- Clear user report logs'
sudo rm -rfv ~/Library/Logs/*
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------------Clear daily logs---------------------
# ----------------------------------------------------------
echo '--- Clear daily logs'
sudo rm -fv /System/Library/LaunchDaemons/com.apple.periodic-*.plist
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------Clear receipt logs for installed packages/apps------
# ----------------------------------------------------------
echo '--- Clear receipt logs for installed packages/apps'
sudo rm -rfv /var/db/receipts/*
sudo rm -vf /Library/Receipts/InstallHistory.plist
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------------Clear privacy.sexy script history-------------
# ----------------------------------------------------------
echo '--- Clear privacy.sexy script history'
# Clear directory contents: "$HOME/Library/Application Support/privacy.sexy/runs"
glob_pattern="$HOME/Library/Application Support/privacy.sexy/runs/*"
rm -rfv $glob_pattern
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------------Clear privacy.sexy activity logs-------------
# ----------------------------------------------------------
echo '--- Clear privacy.sexy activity logs'
# Clear directory contents: "$HOME/Library/Logs/privacy.sexy"
glob_pattern="$HOME/Library/Logs/privacy.sexy/*"
rm -rfv $glob_pattern
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------------Clear Adobe cache---------------------
# ----------------------------------------------------------
echo '--- Clear Adobe cache'
sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------------Clear Gradle cache--------------------
# ----------------------------------------------------------
echo '--- Clear Gradle cache'
if [ -d "~/.gradle/caches" ]; then
    rm -rfv ~/.gradle/caches/ &> /dev/null
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------------------Clear Dropbox cache--------------------
# ----------------------------------------------------------
echo '--- Clear Dropbox cache'
if [ -d "~/Dropbox/.dropbox.cache" ]; then
    sudo rm -rfv ~/Dropbox/.dropbox.cache/* &>/dev/null
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# -----------Clear Google Drive File Stream cache-----------
# ----------------------------------------------------------
echo '--- Clear Google Drive File Stream cache'
killall "Google Drive File Stream"
rm -rfv ~/Library/Application\ Support/Google/DriveFS/[0-9a-zA-Z]*/content_cache &>/dev/null
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------------------Clear Composer cache-------------------
# ----------------------------------------------------------
echo '--- Clear Composer cache'
if type "composer" &> /dev/null; then
    composer clearcache &> /dev/null
fi
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
# ---------------Clear old Ruby gem versions----------------
# ----------------------------------------------------------
echo '--- Clear old Ruby gem versions'
if type "gem" &> /dev/null; then
    gem cleanup &>/dev/null
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# -----------------Clear unused Docker data-----------------
# ----------------------------------------------------------
echo '--- Clear unused Docker data'
if type "docker" &> /dev/null; then
    docker system prune -af
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Clear Pyenv-Virtualenv cache---------------
# ----------------------------------------------------------
echo '--- Clear Pyenv-Virtualenv cache'
if [ "$PYENV_VIRTUALENV_CACHE_PATH" ]; then
    rm -rfv $PYENV_VIRTUALENV_CACHE_PATH &>/dev/null
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------------Clear NPM cache----------------------
# ----------------------------------------------------------
echo '--- Clear NPM cache'
if type "npm" &> /dev/null; then
    npm cache clean --force
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------------Clear Yarn cache---------------------
# ----------------------------------------------------------
echo '--- Clear Yarn cache'
if type "yarn" &> /dev/null; then
    echo 'Cleanup Yarn Cache...'
    yarn cache clean --force
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
# ---------Clear Xcode's derived data and archives----------
# ----------------------------------------------------------
echo '--- Clear Xcode'\''s derived data and archives'
rm -rfv ~/Library/Developer/Xcode/DerivedData/* &>/dev/null
rm -rfv ~/Library/Developer/Xcode/Archives/* &>/dev/null
rm -rfv ~/Library/Developer/Xcode/iOS Device Logs/* &>/dev/null
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
