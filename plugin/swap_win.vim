function! SwapWindows(target_win)
    let cur_buffer = bufnr("%")
    let cur_win = winnr()

    let target_buffer = winbufnr(a:target_win)

    execute 'buffer ' . target_buffer
    execute a:target_win . 'wincmd w'
    execute 'buffer ' . cur_buffer
endfunction


" use like this N<leader>m
" to swap current buffer with the one in window N
nnoremap <leader>m :<C-u>call SwapWindows(v:count)<cr>
