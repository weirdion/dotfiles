# Should contain PATH and env prefs

# env

# zsh history control
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=12000  # HISTSIZE needs to be greater than SAVEHIST for HIST_EXPIRE_DUPS_FIRST
export SAVEHIST=10000
export HISTORY_IGNORE="(ls|cat)"

# Path to your oh-my-zsh installation.
[ -d ${HOME}/.oh-my-zsh ] && export ZSH="${HOME}/.oh-my-zsh"

export ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# options man - http://zsh.sourceforge.net/Doc/Release/Options.html

# options - directory
setopt  pushd_ignore_dups

# options - history
setopt  hist_subst_pattern
setopt  hist_expire_dups_first
setopt  hist_ignore_all_dups
setopt  hist_reduce_blanks
setopt  hist_save_no_dups
setopt  inc_append_history

# options - expansion/globbing
setopt  complete_aliases
# setopt  warn_create_global

# options - jobs
setopt  long_list_jobs
setopt  monitor
setopt  notify

# options - scripts/functions
setopt  NO_verbose
setopt  NO_xtrace

# options - shell emulation
setopt  NO_continue_on_error
. "$HOME/.cargo/env"
