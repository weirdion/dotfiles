# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && \
  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Not needed for initial startup, but source doesn't include changes to zshenv
source ~/.zshenv
bindkey -v

# comp
zstyle :compinstall filename '${HOME}/.zshrc'
# compinit - command completion
autoload -Uz compinit promptinit
compinit
promptinit

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.ex
plugins=(
  git
  colored-man-pages
  safe-paste
  zsh-autosuggestions
  zsh-completions
  history-substring-search
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# personal configs
export DOTFILES_DIR="$HOME/workspace/dotfiles"
source "$DOTFILES_DIR/config/shell_common/env.sh"

[ -f $HOME/.p10k.zsh ] && source $HOME/.p10k.zsh

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && \
  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
