" Auto-commands
augroup SourceVimFiles
    autocmd!
    autocmd BufWritePost *.vim source %
    autocmd BufWritePost $MYVIMRC source %
augroup END

augroup requirements
    autocmd!
    autocmd Bufread requirements*.txt set filetype=requirementstxt
augroup END

augroup cursorline_
    autocmd!
    autocmd BufEnter * set cursorline
    autocmd BufLeave * set nocursorline
augroup END

augroup terminal
    autocmd!
    " Respect Sp/Spawn intent: resize only when flagged by the window
    autocmd TerminalWinOpen * if exists('w:sp_should_resize') | execute 'resize ' . get(w:, 'sp_resize_height', 30) | unlet w:sp_should_resize w:sp_resize_height | endif | setlocal wfh
augroup END
