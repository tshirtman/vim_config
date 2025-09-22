" Keep track of user-defined fixed window dimensions and reapply them.
if exists('g:loaded_fixedsize_plugin')
  finish
endif
let g:loaded_fixedsize_plugin = 1

let s:restoring = 0

function! s:StoreAllFixedSizes() abort
  for l:info in getwininfo()
    let l:winid = l:info.winid
    if getwinvar(l:winid, 'fixed_width', 0)
      call setwinvar(l:winid, 'fixed_width_value', l:info.width)
    endif
    if getwinvar(l:winid, 'fixed_height', 0)
      call setwinvar(l:winid, 'fixed_height_value', l:info.height)
    endif
  endfor
endfunction

function! s:RestoreAllFixedSizes() abort
  if s:restoring
    return
  endif
  let s:restoring = 1
  try
    for l:info in getwininfo()
      let l:winid = l:info.winid
      if getwinvar(l:winid, 'fixed_width', 0)
        let l:width = getwinvar(l:winid, 'fixed_width_value', 0)
        if l:width > 0
          call win_execute(l:winid, 'silent! vert resize ' . l:width)
        endif
      endif
      if getwinvar(l:winid, 'fixed_height', 0)
        let l:height = getwinvar(l:winid, 'fixed_height_value', 0)
        if l:height > 0
          call win_execute(l:winid, 'silent! resize ' . l:height)
        endif
      endif
    endfor
  finally
    let s:restoring = 0
  endtry
endfunction

function! s:SetFixedWidth(width) abort
  let l:target = a:width > 0 ? a:width : winwidth(0)
  if l:target <= 0
    return
  endif
  call setwinvar(0, 'fixed_width', 1)
  call setwinvar(0, 'fixed_width_value', l:target)
  setlocal winfixwidth
  call s:RestoreAllFixedSizes()
endfunction

function! s:SetFixedHeight(height) abort
  let l:target = a:height > 0 ? a:height : winheight(0)
  if l:target <= 0
    return
  endif
  call setwinvar(0, 'fixed_height', 1)
  call setwinvar(0, 'fixed_height_value', l:target)
  setlocal winfixheight
  call s:RestoreAllFixedSizes()
endfunction

function! s:ClearFixedWidth() abort
  call setwinvar(0, 'fixed_width', 0)
  call setwinvar(0, 'fixed_width_value', 0)
  setlocal nowinfixwidth
endfunction

function! s:ClearFixedHeight() abort
  call setwinvar(0, 'fixed_height', 0)
  call setwinvar(0, 'fixed_height_value', 0)
  setlocal nowinfixheight
endfunction

function! s:ToggleFixedWidth() abort
  if getwinvar(0, 'fixed_width', 0)
    call s:ClearFixedWidth()
  else
    call s:SetFixedWidth(0)
  endif
endfunction

function! s:ToggleFixedHeight() abort
  if getwinvar(0, 'fixed_height', 0)
    call s:ClearFixedHeight()
  else
    call s:SetFixedHeight(0)
  endif
endfunction

function! s:CmdSetFixedWidth(arg) abort
  let l:value = strlen(a:arg) ? str2nr(a:arg) : 0
  call s:SetFixedWidth(l:value)
endfunction

function! s:CmdSetFixedHeight(arg) abort
  let l:value = strlen(a:arg) ? str2nr(a:arg) : 0
  call s:SetFixedHeight(l:value)
endfunction

function! s:CmdSetFixedSize(width, height) abort
  call s:SetFixedWidth(str2nr(a:width))
  call s:SetFixedHeight(str2nr(a:height))
endfunction

function! s:CmdClearFixedSize(_) abort
  call s:ClearFixedWidth()
  call s:ClearFixedHeight()
endfunction

function! s:CmdClearFixedWidth(_) abort
  call s:ClearFixedWidth()
endfunction

function! s:CmdClearFixedHeight(_) abort
  call s:ClearFixedHeight()
endfunction

command! -nargs=? SetFixedWidth call s:CmdSetFixedWidth(<q-args>)
command! -nargs=? SetFixedHeight call s:CmdSetFixedHeight(<q-args>)
command! -nargs=2 SetFixedSize call s:CmdSetFixedSize(<f-args>)
command! -nargs=0 ClearFixedSize call s:CmdClearFixedSize('')
command! -nargs=0 ClearFixedWidth call s:CmdClearFixedWidth('')
command! -nargs=0 ClearFixedHeight call s:CmdClearFixedHeight('')

nnoremap <silent> <Plug>(FixedSizeToggleWidth) :<C-u>call <SID>ToggleFixedWidth()<CR>
nnoremap <silent> <Plug>(FixedSizeToggleHeight) :<C-u>call <SID>ToggleFixedHeight()<CR>

augroup FixedSizeAutoGroup
  autocmd!
  autocmd WinEnter,BufWinEnter,TabEnter * call s:RestoreAllFixedSizes()
  autocmd WinClosed * call s:RestoreAllFixedSizes()
  autocmd VimResized * call s:RestoreAllFixedSizes()
  autocmd WinLeave * call s:StoreAllFixedSizes()
  autocmd WinResized * if !s:restoring | call s:StoreAllFixedSizes() | endif
  autocmd CmdlineLeave * if getcmdtype() == ':' && getcmdline() =~# '^\s*\%(vert\%[ical]\s\+\)\?res\%[ize]\>'
        \ && !s:restoring | call s:StoreAllFixedSizes() | endif
augroup END
