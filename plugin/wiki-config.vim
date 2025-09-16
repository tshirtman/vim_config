" when closing the window, if the filetype is wiki, save and destroy the buffer
augroup wiki
    autocmd!
    autocmd FileType vimwiki setlocal nohidden
    autocmd BufWinLeave * if &filetype ==# 'vimwiki' | silent! bwipeout | endif
augroup END
