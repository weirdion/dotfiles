" vim config 
" Can be moved to or be sym-linked to $HOME

set encoding=utf-8
set autoindent
set backspace=indent,eol,start

set number

filetype off
filetype plugin indent on
syntax on

" Global tab width.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Set to show invisibles (tabs & trailing spaces) & their highlight color
set list listchars=tab:»\ ,trail:·

" Configure spell checking
set spelllang=en_us

