" General keymaps (non-plugin)
inoremap <Right> <nop>
inoremap <Left> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>

nnoremap <Right> <nop>
nnoremap <Left> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>

nnoremap yom :silent set mouse~=a
nnoremap WW :w<cr>
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
nnoremap <leader>n :noh<cr>
nnoremap qn :cn<cr>
nnoremap qp :cp<cr>
nnoremap <esc><esc> :lcl<cr>
nnoremap yofh :set wfh<cr>
nnoremap yofw :set wfw<cr>

nnoremap <silent> g<CR> :Sp<CR>
nnoremap <silent> g\| :vert Sp<CR>
" works when hitting <c-w> g<cr> but causes issue when typing g<enter> in
" insert mode of the terminal
tnoremap <silent> <c-w>g<CR> <c-w>:Sp<CR>
tnoremap <silent> <c-w>g\| <c-w>:vert Sp<CR>

" ctags quick Tag jump (if available)
nnoremap <leader>T :Tag<cr>
" copy current file path to clipboard (if available)
nnoremap <leader>cp :let @+ = expand('%:p')<CR>

" bepo single quote convenience
imap ’ '
nmap ’ '
cmap ’ '
tmap ’ '
