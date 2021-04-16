#!/usr/bin/env sh

# Machine based options
case "$(uname -s)" in
	Linux*)
		MACHINE=Linux
	;;
	Darwin*)
		MACHINE=Darwin
	;;
	# Windows git prompt
	MINGW*)
		MACHINE=MinGw
	;;
	*)
		MACHINE="UNKNOWN:$(uname -s)"
	;;
esac

export MACHINE

# User specific env

if ! [[ "$PATH" =~ ${HOME}/.local/bin:${HOME}/bin:${DOTFILES_DIR}/bin: ]]
then
    export PATH="$HOME/.local/bin:$HOME/bin:$DOTFILES_DIR/bin:$PATH"
fi

# toolbox
[ -d "$HOME/.toolbox" ] && export PATH=$HOME/.toolbox/bin:$PATH

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT" ] && export PATH="$PYENV_ROOT/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
