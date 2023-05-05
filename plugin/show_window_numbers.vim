"
function! Chunk(list)
    let chunks = []
    let chunk = []
    for item in a:list
        call add(chunk, item)
        if item =~ '^ *$' && len(chunk) > 0
            call add(chunks, chunk)
            let chunk = []
        endif
    endfor
    if len(chunk) > 0
        call add(chunks, chunk)
    endif
    return chunks
endfunction


" Define the function to display the window numbers
function! ShowWindowNumbers()
  let popup_height = 5
  let popup_width = 8
  let figlet_output = system('figlet -f small ' . join(range(1, winnr('$')), '\r'))
  let popup_content = Chunk(split(figlet_output, "\n"))
  for i in range(1, winnr('$'))
    let winid = win_getid(i)
    let row = win_screenpos(i)[0] + (winheight(i) - popup_height) / 2
    let col = win_screenpos(i)[1] + (winwidth(i) - popup_width) / 2
    let popup_options = {
        \ 'win': winid,
        \ 'wrap': 0,
        \ 'maxheight': popup_height,
        \ 'maxwidth': popup_width,
        \ 'minheight': popup_height,
        \ 'minwidth': popup_width,
        \ 'line': row,
        \ 'col': col,
        \ 'time': 1000,
        \ 'style': 'minimal',
        \ 'border': [],
        \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
        \ }
        " \ 'title': 'Window ' . i,
    call popup_create(popup_content[i - 1], popup_options)
  endfor
endfunction

" Map the function to a key binding
nnoremap <silent> <C-wssn :call ShowWindowNumbers()<CR>
