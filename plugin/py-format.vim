" Python formatting and syntax boosts

" Better Python highlighting
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0

" On-save Black formatting (configurable)
if !exists('g:py_format_use_black')
  let g:py_format_use_black = 1
endif

if g:py_format_use_black
  augroup PyFormatBlack
    autocmd!
    autocmd BufWritePre *.py if exists(':Black') == 2 | silent! Black | endif
  augroup END
endif

" Optional Ruff helpers
command! -nargs=* PyFixRuff call s:PyFixRuff(<f-args>)

function! s:PyFixRuff(...) abort
  if executable('ruff')
    if exists(':AsyncRun') == 2
      execute 'AsyncRun ruff --fix %'
    else
      " Blocking fallback
      write
      call system('ruff --fix ' . shellescape(@%))
      edit
    endif
  else
    echo "ruff not found in PATH"
  endif
endfunction

