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

