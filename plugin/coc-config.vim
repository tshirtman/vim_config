highlight CocErrorHighlight cterm=underline
highlight CocErrorSign      ctermfg=Red
highlight CocWarningSign    ctermfg=Brown
highlight CocInfoSign       ctermfg=Yellow
highlight CocHintSign       ctermfg=Blue

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Disable startup warning
let g:coc_disable_startup_warning = 1

" Keymaps
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gru <Plug>(coc-references-used)
nmap <leader>rf <Plug>(coc-refactor)
nmap <leader>rc <Plug>(coc-codeaction-cursor)
vmap <leader>rc <Plug>(coc-codeaction-selected)
nmap <leader>f <Plug>(coc-fix-current)
nmap <silent> K :call CocAction('doHover')<CR>

" Highlight current symbol on idle
autocmd CursorHold * silent call CocActionAsync('highlight')
