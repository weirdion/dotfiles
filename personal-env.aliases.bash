#!/usr/bin/env bash

# Aliases
alias cd..='cd ..' # Because I'm stupid
alias ls='ls -ahl --color=auto'
alias grep='grep --color=auto'
alias ping='ping -c 5'
alias vbrc="vim ~/.bashrc"
alias checkOpenPorts="sudo netstat -plnt"

alias wget='wget -c'
alias generateRandomPassword="openssl rand -base64 19"

# curl
# follow redirects
alias curll='curl -L'
# follow redirects, download as original name, continue
alias curlloc='curl -L -C - -O'
# see only response headers from request
alias curlhead='curl -D - -so /dev/null'
alias whatsmyip='curl ipinfo.io/ip'

# tar
alias tarup='tar -I lbzip2 -cvf'
alias tardown='tar -I lbzip2 -xvf'

# xclip
alias xcopy="xclip -selection clipboard"
alias xpaste="xclip -selection clipboard -o"

# Probably don't need this, but just because
# shellcheck disable=SC1012
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
