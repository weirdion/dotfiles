# Aliases
alias cd..='cd ..' # Because I'm stupid
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

alias ping='ping -c 5'
alias checkOpenPorts="netstat -tlpn"

alias wget='wget -c'
alias generateRandomPassword="openssl rand -base64 19"
alias dockerRemoveAllImages='docker rmi -f $(docker images -a -q)'

# curl
# follow redirects
alias curl='curl -L'
# follow redirects, download as original name, continue
alias curlloc='curl -L -C - -O'
# see only response headers from request
alias curlhead='curl -D - -so /dev/null'
alias whatsmyip='curl ipinfo.io/ip'

# tar
alias tarup='tar -I lbzip2 -cvf'
alias tardown='tar -I lbzip2 -xvf'

# Probably don't need this, but just because
# shellcheck disable=SC1012
alias removeTrailingWinCrap="sed -i 's/\r$//'"

# Unused Aliases

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
