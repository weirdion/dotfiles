#!/usr/bin/env sh

DOTFILES_DIR="$HOME/workspace/dotfiles"

# Do shell_work first to not allow any overrides
local scriptDir="${$(dirname $0)%/shell_common}"
# Source exports from shell_work
if [ -d "$scriptDir/shell_work" ]; then
  if [ -n "$(ls -A "$scriptDir/shell_work"/*.sh 2>/dev/null)" ]; then
    for e in "$scriptDir/shell_work"/*.sh; do
      echo "====> Sourcing work export $e"
      source "$e"
    done
  fi
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

# Start the gpg-agent
gpgconf --launch gpg-agent
