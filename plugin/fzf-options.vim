let g:fzf_layout={'down': '~20%'}
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Mappings
nnoremap <c-b> :FZF<cr>
nnoremap <silent><leader>. :Buffers<cr>
if executable('rg')
  nnoremap <silent><leader>/ :Rg<cr>
else
  nnoremap <silent><leader>/ :Ag<cr>
endif
nnoremap <silent><leader>b :Lines<cr>
" ctags via FZF if available, otherwise fallback
nnoremap <leader>T :Tag<cr>
