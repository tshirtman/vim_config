" Airline-specific theme adjustments
let g:airline_theme_patch_func = 'AirlineThemePatch'

function! AirlineThemePatch(palette)
  if g:airline_theme == 'onehalfdark'
    highlight airline_term ctermbg=238
    highlight airline_term_inactive ctermbg=238
  endif
endfunction

function! s:update_highlights()
  highlight StatusLine ctermbg=1 ctermfg=2 term=bold
  highlight StatusLineNC ctermbg=1 ctermfg=2
  highlight StatusLineTerm ctermbg=3 ctermfg=1 term=underline
  highlight ErrorMsg ctermfg=NONE ctermbg=8
endfunction

autocmd User AirlineAfterTheme call s:update_highlights()
