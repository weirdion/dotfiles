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
set tabstop=4  " width of t a tab
set shiftwidth=4  " indents width
set softtabstop=4  " number of columns for a tab
set expandtab  " expand tab into spaces

" Set to show invisibles (tabs & trailing spaces) & their highlight color
set list listchars=tab:»\ ,trail:·

" Configure spell checking
set spelllang=en_us

