setlocal sw=2 ts=2
let g:indent_guides_auto_colors = 1

let g:indent_guides_auto_colors = 0

augroup XMLLoad
    au!
    au BufLeave *.xml IndentGuidesDisable
    au BufEnter *.xml IndentGuidesEnable
    aut VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
    aut VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
augroup END
