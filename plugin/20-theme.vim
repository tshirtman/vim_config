" Theme and highlights
function! s:setcolors()
    if &background == 'dark'
        colorscheme onehalfdark
        highlight Normal ctermbg=234
        highlight NormalNC ctermbg=232
        highlight NonText ctermbg=234
        highlight Comment ctermfg=230 cterm=bold
        highlight CursorColumn ctermbg=234
        highlight Pmenu ctermbg=233 ctermfg=7
        highlight Visual cterm=reverse
        highlight VertSplit ctermbg=234 ctermfg=238
        highlight StatusLine ctermbg=3 ctermfg=1 term=bold
        highlight StatusLineNC ctermbg=3 ctermfg=1 cterm=reverse
        highlight StatusLineTerm ctermbg=3 ctermfg=1 term=underline
        highlight CocInlayHint ctermfg=230
    else
        colorscheme onehalflight
        highlight Normal ctermbg=231
        highlight NormalNC ctermbg=255
        highlight Comment ctermfg=233 cterm=bold
        highlight VertSplit ctermbg=255 ctermfg=254
    endif
endfunction

augroup background
    autocmd!
    autocmd OptionSet background call s:setcolors()
augroup END

" different color depending on focus
hi NormalNC ctermbg=0
augroup winbg
    autocmd!
    au WinEnter * setl wincolor=
    au WinLeave * setl wincolor=NormalNC
augroup END

" apply initial colors
call s:setcolors()
