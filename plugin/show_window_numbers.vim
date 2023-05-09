let s:numbers = {
      \ '0': [
      \ '█████',
      \ '██  █',
      \ '██  █',
      \ '██  █',
      \ '█████',
      \ ],
      \ '1': [
      \ '  ██  ',
      \ '████  ',
      \ '  ██  ',
      \ '  ██  ',
      \ '██████',
      \ ],
      \ '2': [
      \ '█████',
      \ '   ██',
      \ '█████',
      \ '██   ',
      \ '█████',
      \ ],
      \ '3': [
      \ '█████',
      \ '   ██',
      \ '█████',
      \ '   ██',
      \ '█████',
      \ ],
      \ '4': [
      \ '█  ██',
      \ '█  ██',
      \ '█████',
      \ '   ██',
      \ '   ██',
      \ ],
      \ '5': [
      \ '█████',
      \ '██   ',
      \ '█████ ',
      \ '   ██',
      \ '█████',
      \ ],
      \ '6': [
      \ '█████',
      \ '██   ',
      \ '█████',
      \ '██  █ ',
      \ '█████',
      \ ],
      \ '7': [
      \ '██████',
      \ '   ██ ',
      \ '  ██  ',
      \ ' ██   ',
      \ '██    ',
      \ ],
      \ '8': [
      \ '█████',
      \ '█  ██',
      \ '█████',
      \ '█  ██',
      \ '█████',
      \ ],
      \ '9': [
      \ '█████',
      \ '█  ██',
      \ '█████',
      \ '   ██',
      \ '█████',
      \ ]
      \ }

function! DisplayNumber(number)
  if a:number < 0
    echoerr 'Number must be positive'
    return ''
  elseif a:number < 10
      return s:numbers[a:number]
  endif

  let number_str = string(a:number)
  let display = []
  for line in range(0, 4)
    let line_str = ''
    for digit in number_str
      let line_str .= s:numbers[str2nr(digit)][line] . ' '
    endfor
    call add(display, line_str)
  endfor
  return display
endfunction

" Define the function to display the window numbers
function! ShowWindowNumbers()
  for i in range(1, winnr('$'))
    let content = DisplayNumber(i)
    let winid = win_getid(i)
    let row = win_screenpos(i)[0] + (winheight(i)) / 2
    let col = win_screenpos(i)[1] + (winwidth(i)) / 2
    let popup_options = {
        \ 'win': winid,
        \ 'wrap': 0,
        \ 'line': row,
        \ 'col': col,
        \ 'time': 2100,
        \ 'border': [],
        \ 'padding': [2, 2, 2, 2],
        \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
        \ }
    call popup_create(content, popup_options)
  endfor
endfunction

" Map the function to a key binding
nnoremap <silent> <C-w>n :call ShowWindowNumbers()<CR>
