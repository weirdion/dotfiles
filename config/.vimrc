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
set tabstop=4  " width of a tab character
set shiftwidth=4  " width for auto-indents
set softtabstop=4  " number of spaces for a tab
set expandtab  " convert tabs to spaces

" Set to show invisibles (tabs & trailing spaces) & their highlight color
set list listchars=tab:»\ ,trail:·

" Configure spell checking
set spell
set spelllang=en_us

" Specific file-type overrides
autocmd BufRead,BufNewFile *.yml,*.yaml setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
