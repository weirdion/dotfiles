# Darwin specific aliases and functions

# Aliases
alias dnd="launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null"
alias udnd="launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null"
alias lsblk='diskutil list'
alias md5sum="md5"
alias sha1sum="shasum"
alias ls='ls -ahl -G'
alias grep='grep -G'
