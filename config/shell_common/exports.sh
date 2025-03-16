#!/usr/bin/env sh

# export BROWSER=/usr/bin/brave-browser-stable
export EDITOR=/usr/bin/vim

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

# SDK and programming stuff
export SDK_DIR="$homeDir/sdk"

# Homebrew
[[ $MACHINE == "Darwin" ]] && export HOMEBREW_PATH="/opt/homebrew"

# Path
if ! [[ "$PATH" =~ ${HOME}/.local/bin:${HOME}/bin:${DOTFILES_DIR}/bin: ]]
then
    export PATH="$HOME/.local/bin:$HOME/bin:$DOTFILES_DIR/bin:$HOMEBREW_PATH/bin:$PATH"
fi

# toolbox
[ -d "$HOME/.toolbox" ] && export PATH=$HOME/.toolbox/bin:$PATH

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT" ] && export PATH="$PYENV_ROOT/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
export NPM_USER_DIR="$HOME/node_modules/.bin"
if [[ $MACHINE == "Darwin" ]]; then
	[ -s "$HOMEBREW_PATH/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PATH/opt/nvm/nvm.sh"  # This loads nvm
else
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi
! [[ $PATH =~ ${NPM_USER_DIR} ]] && export PATH="${NPM_USER_DIR}:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Go
GOPATH="${HOME}/go"
[ -d "$GOPATH" ] && export GOPATH="$GOPATH"
[ -d "$GOPATH" ] && ! [[ $PATH =~ ${GOPATH}/bin ]] && export PATH="${GOPATH}/bin:$PATH"

# Rust
RUSTUP_HOME="$HOME/.rustup"
CARGO_HOME="$HOME/.cargo"
[ -d "$RUSTUP_HOME" ] && export RUSTUP_HOME="$RUSTUP_HOME"
[ -d "$RUSTUP_HOME" ] && ! [[ $PATH =~ ${RUSTUP_HOME}/bin ]] && export PATH="${RUSTUP_HOME}/bin:$PATH"
[ -d "$CARGO_HOME" ] && export CARGO_HOME="$CARGO_HOME"
[ -d "$CARGO_HOME" ] && ! [[ $PATH =~ ${CARGO_HOME}/bin ]] && export PATH="${CARGO_HOME}/bin:$PATH"

# Rancher Desktop
RANCHER_HOME="$HOME/.rd"
[ -d "$RANCHER_HOME" ] && export RANCHER_HOME="$RANCHER_HOME"
[ -d "$RANCHER_HOME" ] && ! [[ $PATH =~ ${RANCHER_HOME}/bin ]] && export PATH="${RANCHER_HOME}/bin:$PATH"

# GPG
export GPG_TTY=$(tty)
