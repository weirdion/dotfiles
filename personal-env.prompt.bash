
# For bash history

# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:* --version"; # Make some commands not show up in history
HISTSIZE=10000
HISTFILESIZE="$HISTSIZE"
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# For Tilix
if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
    source /etc/profile.d/vte.sh
fi

# for regular prompt
if [[ -n "$BASH_VERSION" ]]; then
    export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(__parse_git_branch)\[\033[00m\] $ "
fi

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
