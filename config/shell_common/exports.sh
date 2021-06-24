#!/usr/bin/env sh

export BROWSER=/usr/bin/brave-browser-stable
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

# toolbox
[ -d "$HOME/.toolbox" ] && export PATH=$HOME/.toolbox/bin:$PATH

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT" ] && export PATH="$PYENV_ROOT/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
export NPM_USER_DIR="$HOME/node_modules/.bin"
! [[ $PATH =~ ${NPM_USER_DIR} ]] && export PATH="${NPM_USER_DIR}:$PATH"

# Go
export GOPATH="${HOME}/go"
! [[ $PATH =~ ${ANDROID_HOME}/platform-tools ]] && export PATH="${ANDROID_HOME}/platform-tools:$PATH"

# Android
export ANDROID_HOME="$SDK_DIR/android-sdk"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk-bundle/"
! [[ $PATH =~ ${GOPATH}/bin ]] && export PATH="${GOPATH}/bin:$PATH"

# Flutter
export FLUTTER_HOME="$SDK_DIR/flutter"
! [[ $PATH =~ ${FLUTTER_HOME}/bin ]] && export PATH="${FLUTTER_HOME}/bin:$PATH"

# Path

if ! [[ "$PATH" =~ ${HOME}/.local/bin:${HOME}/bin:${DOTFILES_DIR}/bin: ]]
then
    export PATH="$HOME/.local/bin:$HOME/bin:$DOTFILES_DIR/bin:$PATH"
fi
