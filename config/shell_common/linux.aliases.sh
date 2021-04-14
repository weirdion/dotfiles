# Linux specific aliases and functions

alias pacman="yay"
alias yayUpdate='yay -Syu --sudoloop --answerclean n --answerdiff a'

# list all the packages installed w/o dependencies
alias list-all-packages=’pacman -Qet’

# xclip
alias xcopy="xclip -selection clipboard"
alias xpaste="xclip -selection clipboard -o"
