# For bash history

# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
HISTIGNORE="ls:cd:cd ..:cd -:pwd:exit:date:* --help:* --version:systemctl status*"; # Make some commands not show up in history
HISTSIZE=10000
HISTFILESIZE="$HISTSIZE"
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# Machine based options
case "$(uname -s)" in
	Linux*)
		machine=Linux
	;;
	Darwin*)
		machine=Darwin
	;;
	# Windows git prompt
	MINGW*)
		machine=MinGw
	;;
	*)
		machine="UNKNOWN:$(uname -s)"
	;;
esac

DOTFILES_DIR="~/workspace/dotfiles"

# User specific environment

export PYENV_ROOT="$HOME/.pyenv"

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
    export PATH
fi

# toolbox
[ -d "$HOME/.toolbox" ] && export PATH=$HOME/.toolbox/bin:$PATH
# pyenv
[ -d "$PYENV_ROOT" ] && export PATH="$PYENV_ROOT/bin:$PATH"

# personal configs
source "$DOTFILES_DIR/config/shell_common/aliases.sh"
source "$DOTFILES_DIR/config/shell_common/functions.bash"

if [ $machine == "Darwin" ]; then
  source "$DOTFILES_DIR/config/shell_common/darwin.aliases.sh"
else
  source "$DOTFILES_DIR/config/shell_common/linux.aliases.sh"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi 

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
