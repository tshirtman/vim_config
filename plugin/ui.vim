" UI helpers
function! ToggleSignColumn()
  if !exists("b:signcolumn_on") || b:signcolumn_on
    set signcolumn=no
    let b:signcolumn_on=0
  else
    set signcolumn=number
    let b:signcolumn_on=1
  endif
endfunction

nnoremap yoS :call ToggleSignColumn()<CR>
