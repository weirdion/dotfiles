#!/usr/bin/env sh

DOTFILES_DIR="$HOME/workspace/dotfiles"

source "$DOTFILES_DIR/config/shell_common/exports.sh"
source "$DOTFILES_DIR/config/shell_common/aliases.sh"
source "$DOTFILES_DIR/config/shell_common/functions.bash"

# Python
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# For Tilix
if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
    source /etc/profile.d/vte.sh
fi

# Mac only path_helper
if [[ -x /usr/libexec/path_helper ]]; then
  eval $(/usr/libexec/path_helper -s)
fi

# Linux HomeBrew helper
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
