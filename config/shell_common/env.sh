#!/usr/bin/env bash

DOTFILES_DIR="$HOME/workspace/dotfiles"

# Do shell_work first to not allow any overrides
workScriptDir="$DOTFILES_DIR/config/shell_work"
if [ -d "$workScriptDir" ]; then
  find "$workScriptDir" -name '*.sh' | while read -r e; do
    [ -e "$e" ] || continue
    echo "====> Sourcing work export $e"
    # intentionally non-constant
    # shellcheck disable=SC1090
    source "$e"
  done
fi

if [ "$MACHINE" = "Darwin" ]; then
  source "$DOTFILES_DIR/config/shell_common/darwin.aliases.sh"
  export PATH="$HOMEBREW_PATH/bin:$PATH"
else
  source "$DOTFILES_DIR/config/shell_common/linux.aliases.sh"
fi

source "$DOTFILES_DIR/config/shell_common/exports.sh"
source "$DOTFILES_DIR/config/shell_common/aliases.sh"
source "$DOTFILES_DIR/config/shell_common/functions.bash"

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# For Tilix
if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
    source /etc/profile.d/vte.sh
fi

# Mac only path_helper
if [[ -x /usr/libexec/path_helper ]]; then
  eval "$(/usr/libexec/path_helper -s)"
fi

# Linux HomeBrew helper
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Start the gpg-agent
gpgconf --launch gpg-agent

# Python
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi
