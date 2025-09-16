" Terminal spawning helpers that respect command modifiers

function! s:SpawnImpl(mods, qargs) abort
  let l:cmd = empty(a:qargs) ? $SHELL : a:qargs

  if a:mods =~# '\<vert\%[ical]\>'
    " Vertical split; leave size untouched
    execute a:mods . ' split'
  else
    " Horizontal split; mark for resize via autocmd
    split
    let w:sp_should_resize = 1
    let w:sp_resize_height = 30
  endif

  execute 'term ++curwin ++close ' . l:cmd
  setlocal wfh
endfunction

command! -nargs=* -complete=shellcmd Sp call s:SpawnImpl('<mods>', <q-args>)
command! -nargs=* -complete=shellcmd Spawn call s:SpawnImpl('<mods>', <q-args>)
