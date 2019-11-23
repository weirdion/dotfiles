
# For bash history
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000
shopt -s histappend

# For Tilix
if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
    source /etc/profile.d/vte.sh
fi

# for regular prompt
if [[ -n "$BASH_VERSION" ]]; then
    export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(__parse_git_branch)\[\033[00m\] $ "
fi
