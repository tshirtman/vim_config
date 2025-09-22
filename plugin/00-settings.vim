" Core editor settings
set encoding=UTF-8
set t_Co=256
set shell=fish
set splitbelow splitright
set noequalalways

if !exists("background_loaded")
    let background_loaded=1
    set background=dark
endif

set bs=indent,eol,start
set hidden
set autowrite
set autoread
set lazyredraw

set undofile
set directory=~/.vim/swap/
set undodir=~/.vim/undo/

set incsearch
set ignorecase
set smartcase
set updatetime=300

" don't treat numbers with leading 0s as octal on ^A/^X
set nrformats-=octal

set fillchars+=vert:\▏
let g:zip_nomax=1
