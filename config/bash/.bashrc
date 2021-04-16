# For bash history

# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
HISTIGNORE="ls:cd:cd ..:cd -:pwd:exit:date:* --help:* --version:systemctl status*"; # Make some commands not show up in history
HISTSIZE=10000
HISTFILESIZE="$HISTSIZE"
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

export DOTFILES_DIR="$HOME/workspace/dotfiles"

source "$DOTFILES_DIR/config/shell_common/env.sh"
if [ "$MACHINE" == "Darwin" ]; then
  source "$DOTFILES_DIR/config/shell_common/darwin.aliases.sh"
else
  source "$DOTFILES_DIR/config/shell_common/linux.aliases.sh"
fi

# personal configs
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# for regular prompt
function __parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
if [[ -n "$BASH_VERSION" ]]; then
    export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(__parse_git_branch)\[\033[00m\] $ "
fi

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
