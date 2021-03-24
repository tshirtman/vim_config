syntax on
filetype on
let mapleader = ","
set encoding=UTF-8
set t_Co=256
set background=dark

set bs=indent,eol,start
set path=.
set hidden
set autowrite
set lazyredraw

set undofile
set directory=~/.vim/swap/ " move swapfiles to a common directory
set undodir=~/.vim/undo/  " put undo files to a common directory

set incsearch
set smartcase
set updatetime=300

source ~/.vim/plugin/plug-list.vim

augroup SourceVimFiles
        autocmd!
        autocmd BufWritePost *.vim source %
        autocmd BufWritePost $MYVIMRC source %
augroup END

inoremap <Right> <nop>
inoremap <Left> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>

nnoremap <Right> <nop>
nnoremap <Left> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
" nnoremap <cr> o<esc>
nnoremap yom :silent set mouse~=a
nnoremap <leader>, <c-w>

nnoremap U :silent redo<cr>
nnoremap <c-c> :silent close<cr>
nnoremap <c-n> :silent vs<cr>

nnoremap <a-n> :cn<cr>
nnoremap <a-p> :cp<cr>

inoremap jj <esc>
nnoremap _ <c-^>

nnoremap <leader>ts :tselect <c-r><c-w><cr>
nnoremap <leader>tj :tjump <c-r><c-w><cr>

nnoremap <leader>ed :e ~/.vim/plugin/
nnoremap <leader>ep :e ~/.vim/plugin/plug-list.vim
nnoremap <leader>ef :e ~/.vim/ftplugin/
nnoremap <leader>ev :e ~/.vim/vimrc

" plugin mappings
nnoremap <c-b> :FZF<cr>
nnoremap <silent><leader>. :Buffers<cr>
nnoremap <silent><leader>/ :Ag<cr>
nnoremap <silent><leader>b :Lines<cr>
nnoremap <silent><leader>h :dateHelptags<cr>

nnoremap <silent><leader>r :NERDTreeToggle<cr>
nnoremap <silent><leader>M :Magit<cr>
nnoremap <silent><leader>m :Merginal<cr>
nnoremap <silent><leader>v :Vista vim_lsp<cr>

nnoremap <silent><leader>gg :UndotreeToggle<cr>
nnoremap <leader>gs :Gstatus<cr>

" COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gru <Plug>(coc-references-used)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)
nmap <leader>f <Plug>(coc-fix-current)
nmap <silent> K :call CocAction('doHover')<CR>

" disable coc warning
let g:coc_disable_startup_warning = 1
autocmd CursorHold * silent call CocActionAsync('highlight')

" theme
function s:setcolors()
    if &background == 'dark'
        colorscheme onehalfdark
        highlight Normal ctermbg=233
        highlight NonText ctermbg=233
	highlight Comment ctermfg=230 cterm=bold
	highlight CursorColumn ctermbg=236
	highlight Pmenu ctermbg=234 ctermfg=7
	highlight Visual ctermbg=240
    else
        colorscheme onehalflight
    endif
endfunction

call s:setcolors()

augroup background
    autocmd!
    autocmd OptionSet background call s:setcolors()
augroup END
