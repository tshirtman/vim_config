let g:ale_sign_error="☠️"
let g:ale_sign_warning="⚠️"
let g:ale_set_highlights=0
let g:ale_set_loclist=1
let g:ale_linters = {'python': []}
" let g:ale_linters = {'python': ['flake8', 'mypy', 'pylint', 'pyright']}

highlight ALEWarning cterm=underline
highlight ALEError cterm=underline
