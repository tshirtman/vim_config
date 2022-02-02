syntax on
filetype on
let mapleader = ","
set encoding=UTF-8
set t_Co=256

if !exists("background_loaded")
    " only set the background the first time we load the vimrc
    let background_loaded=1
    set background=dark
endif

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

set fillchars+=vert:\▏

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
nnoremap <leader>p [p
nnoremap <leader>, <c-w>

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
nnoremap <leader>c :lclose<cr>
" looking for swap mappings? g< / g> / gs  see :h swap-keywappings
nnoremap <leader>dd :LspDocumentDiagnostic<cr>

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

" LSP
nmap <leader>dd :LspDocumentDiagnostics<cr>

" disable coc warning
let g:coc_disable_startup_warning = 1
autocmd CursorHold * silent call CocActionAsync('highlight')

" theme
function s:setcolors()
    if &background == 'dark'
        colorscheme onehalfdark
        highlight Normal ctermbg=0
        highlight NonText ctermbg=0
        highlight Comment ctermfg=230 cterm=bold
        highlight CursorColumn ctermbg=236
        highlight Pmenu ctermbg=234 ctermfg=7
        highlight Visual ctermbg=240
        highlight VertSplit ctermbg=0 ctermfg=238
    else
        colorscheme onehalflight
        highlight Comment ctermfg=233 cterm=bold
        highlight VertSplit ctermbg=231 ctermfg=255
    endif
endfunction

call s:setcolors()

augroup background
    autocmd!
    autocmd OptionSet background call s:setcolors()
augroup END

" function s:scroll_float_up()
"     if call #coc#has_float()
        
"     endif
" endfunction
"
" inoremap <c-u> call #coc#float#scroll(-1, 2)
" inoremap <c-d> call #coc#float#scroll(1, 2)
"
nnoremap <Leader>S :call ToggleSignColumn()<CR>

" Toggle signcolumn. Works on vim>=8.1 or NeoVim
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=number
        let b:signcolumn_on=1
    endif
endfunction

function ToggleBg()
    if &background == "light"
      set background=dark
  else
      set background=light
    endif
endfunction

nnoremap <leader>eb :call ToggleBg()<cr>
