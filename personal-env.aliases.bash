#!/usr/bin/env bash

# Aliases
alias cd..='cd ..' # Because I'm stupid
alias ls='ls -ahl --color=auto'
alias grep='grep --color=auto'
alias untar='tar -zxvf'
alias wget='wget -c'
alias generateRandomPassword="openssl rand -base64 19"
alias ping='ping -c 5'
alias whatsmyip='curl ipinfo.io/ip'
alias whatsmyip-local='ipconfig getifaddr en0'

# Probably don't need this, but just because
alias removeTrailingWinCrap='sed -i 's/\r$//''


# Unused Aliases

# list all the packages installed w/o dependencies
# alias list-all=’pacman -Qet’

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
