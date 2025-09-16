" set default command to spawn the process
if !exists('g:dtach_command')
  let g:dtach_command = "Spawn"
endif

" set default value for dtach escape key
let g:dtach_escape_key = '^q'

" set default value for dtach socket directory
let g:dtach_socket_dir = "/tmp/dtach_sockets/"

" check that dtach exists at import time
let dtach_exists = executable('dtach')

" if dtach does not exist, raise an error
if !dtach_exists
    echo "dtach is not installed. Please install dtach to use this plugin."
    echo "see https://github.com/crigler/dtach/"
endif

function! GetDtachSocketDir()
    if !isdirectory(g:dtach_socket_dir)
        call mkdir(g:dtach_socket_dir, 0755)
    endif

    return g:dtach_socket_dir
endfunction


function! DTach(socket_name, command, ...)
    " Determine command to run (fallback to $SHELL)
    let l:cmd = empty(a:command) ? $SHELL : a:command

    " Determine socket name (fallback to first token of command)
    if empty(a:socket_name)
        let l:socket_name = matchstr(l:cmd, '^\S\+')
    else
        let l:socket_name = a:socket_name
    endif

    let l:dtach_socket_dir = GetDtachSocketDir()
    let l:base = l:dtach_socket_dir . l:socket_name
    if getftype(l:base) ==# 'socket'
        let l:socket_file = l:dtach_socket_dir . l:socket_name . "_" . strftime("%Y%m%d%H%M%S")
    else
        let l:socket_file = l:base
    endif

    let l:mods = a:0 >= 1 ? a:1 : ''
    call Spawn(l:socket_file, l:cmd, l:mods)
endfunction


function! DTachAttach(socket_name, ...)
    let dtach_socket_dir = GetDtachSocketDir()
    let socket_file = dtach_socket_dir . a:socket_name
    if getftype(socket_file) != "socket"
        " return an error, we can't join the socket if it doesn't exist
        echo "Error: Socket " . socket_file . " not found!"
        return
    endif
    
    let l:mods = a:0 >= 1 ? a:1 : ''
    call Spawn(socket_file, "dummy", l:mods)
endfunction

function! Spawn(socket_file, command, ...)
    let dtach_command = "dtach -A " . a:socket_file . " -e " . "'" . g:dtach_escape_key . "'" . " " . a:command
    echom "Running command: " . dtach_command
    let l:mods = a:0 >= 1 ? a:1 : ''
    execute (empty(l:mods) ? '' : l:mods . ' ') . g:dtach_command . " " . dtach_command
endfunction

" Interactive / robust wrapper around :DTach that preserves command quoting
function! s:DTachCommand(qargs, mods) abort
    if empty(a:qargs)
        let name = input('dtach name: ')
        let cmd = input('command [$SHELL]: ')
        call DTach(name, cmd, a:mods)
        return
    endif
    let m = matchlist(a:qargs, '^\s*\(\S\+\)\s\+\(.*\)$')
    if len(m) >= 3
        call DTach(m[1], m[2], a:mods)
    else
        call DTach(a:qargs, '', a:mods)
    endif
endfunction

function! s:DTachAttachCommand(qargs, mods) abort
  call DTachAttach(a:qargs, a:mods)
endfunction

function! CompleteDTach(arglead, cmd_line, cursor_pos)
    " Determine argument index (naive split is OK for hinting)
    let parts = split(a:cmd_line)
    let argc = len(parts) - 1 " exclude command name
    if argc <= 1
        " First arg: suggest placeholder and existing sockets to reuse
        let dir = GetDtachSocketDir()
        let sockets = readdir(dir, {n -> getftype(dir . n) ==# 'socket'})
        let base = filter(copy(sockets), 'v:val =~? "^" . escape(a:arglead, "\\.^$~[]")')
        return ['<name>'] + base
    else
        " Second or later arg: complete shell command
        return getcompletion(a:arglead, 'shellcmd')
    endif
endfunction

function! s:fuzzy_match(str, pat) abort
    let s = a:str
    for c in split(a:pat, '\zs')
        let idx = match(s, '\V' . escape(c, '\'))
        if idx < 0
            return 0
        endif
        let s = s[(idx+1):]
    endfor
    return 1
endfunction

function! CompleteDTachAttach(arglead, cmd_line, cursor_pos)
    let dir = GetDtachSocketDir()
    " Only list actual sockets
    let entries = readdir(dir, {n -> getftype(dir . n) ==# 'socket'})

    let lead = a:arglead
    if empty(lead)
        return entries
    endif

    " Prefix match first
    let esc = escape(lead, '\.^$~[]')
    let pref = filter(copy(entries), 'v:val =~? "^" . esc')
    if !empty(pref)
        return pref
    endif

    " Fuzzy (subsequence) match fallback
    return filter(copy(entries), 'call(function("s:fuzzy_match"), [v:val, lead])')
endfunction


command! -nargs=* -complete=customlist,CompleteDTach DTach :call <SID>DTachCommand(<q-args>, '<mods>')
command! -nargs=1 -complete=customlist,CompleteDTachAttach DTachAttach :call <SID>DTachAttachCommand(<q-args>, '<mods>')
