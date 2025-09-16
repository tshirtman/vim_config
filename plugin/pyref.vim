" vim function to lookup the symbol under the cursor on https://pyref.dev/<symbol>"

function! s:get_text(start_line, start_col, end_line, end_col)
    let text = getline(a:start_line)[a:start_col - 1:]
    if a:start_line == a:end_line
        let text = text[a:start_col:]
        return text
    endif

    for i in range(a:tart_line + 1, a:end_line - 1)
        let text = text . "\n" . getline(i)
    endfor
    let last_line = getline(a:end_line)
    let text = text[:end_col]

    let text = text . getline(a:end_line)
    
    return text
endfunction

function! s:getvisualselection()
    let start_line = getpos('.')[1]
    let start_col = getpos('.')[2]

    let end_line = getpos('v')[1]
    let end_col = getpos('v')[2]

    if start_line > end_line || start_col > end_col
        let temp = start_line
        let start_line = end_line
        let end_line = temp

        let temp = start_col
        let start_col = end_col
        let end_col = temp
    endif

    " get the text of the visual selection
    let text = s:get_text(start_line, start_col, end_line, end_col)
    return text
endfunction

function! s:lookup_symbol(symbol) range
    let url = "https://pyref.dev/" . a:symbol
    execute "silent !open " . url
    " wait for the browser to open
    sleep 1000ms
    " redraw
    redraw!
endfunction

" command to lookup the symbol under the cursor"
command! LookupSymbolUnderCursor call s:lookup_symbol(expand('<cword>'))
command! -range LookupSelectedSymbol call s:lookup_symbol(s:getvisualselection())

" debug getvisualselection
command! -range DebugGetVisualSelection call s:getvisualselection()

" create <Plug> mapping
nnoremap <Plug>LookupSymbolUnderCursor :LookupSymbolUnderCursor<CR>
vnoremap <Plug>LookupSelectedSymbol :LookupSelectedSymbol<CR>

" create <Leader> mapping
nnoremap <Leader>ref <Plug>LookupSymbolUnderCursor
vnoremap <Leader>ref <Plug>LookupSelectedSymbol
