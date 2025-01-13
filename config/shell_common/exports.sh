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
export GOPATH="${HOME}/go"
! [[ $PATH =~ ${GOPATH}/bin ]] && export PATH="${GOPATH}/bin:$PATH"

# Android
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk-bundle/"
! [[ $PATH =~ ${ANDROID_HOME}/platform-tools ]] && export PATH="${ANDROID_HOME}/platform-tools:$PATH"

# Rust
export CARGO_HOME="$HOME/.cargo"
! [[ $PATH =~ ${CARGO_HOME}/bin ]] && export PATH="${CARGO_HOME}/bin:$PATH"

# Rancher Desktop
export RANCHER_HOME="$HOME/.rd"
! [[ $PATH =~ ${RANCHER_HOME}/bin ]] && export PATH="${RANCHER_HOME}/bin:$PATH"

# GPG
export GPG_TTY=$(tty)

# Path

if ! [[ "$PATH" =~ ${HOME}/.local/bin:${HOME}/bin:${DOTFILES_DIR}/bin: ]]
then
    export PATH="$HOME/.local/bin:$HOME/bin:$DOTFILES_DIR/bin:$HOMEBREW_PATH/bin:$PATH"
fi
