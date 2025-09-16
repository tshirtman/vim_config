" MinIO Browser using netrw-like UI
function! MinioBrowse(...) abort
  let l:path = get(a:000, 0, '')
  call s:OpenMinioBuffer(l:path)
endfunction

let s:ls_cache = {}

command! -nargs=? MinioBrowse call MinioBrowse(<f-args>)

function! s:OpenMinioBuffer(path) abort
  if !exists('b:minio_browser') || !b:minio_browser
    enew
  endif
  setlocal buftype=nofile bufhidden=wipe noswapfile
  setlocal filetype=minio
  nnoremap <buffer> <CR> :call <SID>MinioOpenItem()<CR>
  nnoremap <buffer> - :call <SID>MinioGoUp()<CR>
  let b:minio_path = a:path
  let b:minio_browser = 1
  " Clear all existing lines
  call deletebufline('%', 1, '$')
  call setline(1, s:ListMinio(a:path))
endfunction

function! s:ListMinio(path) abort
  let lines = []
  if a:path ==# ''
    " Show aliases
    let result = system('mc alias list --json')
    let lines_json = split(result, "\n")
    for line in lines_json
        if line =~ '^{'
            let alias = json_decode(line)
            call add(lines, '[A] ' . alias.alias)
        endif
    endfor
    else
      if has_key(s:ls_cache, a:path)
        return s:ls_cache[a:path]
      endif

      " Show mc ls output for alias/bucket/path
      let result = system('mc ls --json ' . shellescape(a:path))
      if v:shell_error
        return ['<error>']
      endif
      let entries = split(result, "\n")
      for item in entries
        let obj = json_decode(item)
        let icon = (obj.type ==# 'folder') ? '[D]' : '[F]'
        call add(lines, icon . ' ' . obj.key)
      endfor
  endif
  return lines
endfunction

function! s:MinioOpenItem() abort
  let line = getline('.')
  let prefix = strpart(line, 0, 3)
  let name = strpart(line, 4)
  let base = get(b:, 'minio_path', '')

  if prefix ==# '[A]'
    call s:OpenMinioBuffer(name)
  elseif prefix ==# '[D]'
    let path = base . '/' . name
    call s:OpenMinioBuffer(path)
  elseif prefix ==# '[F]'
    let full = base . '/' . name
    let content = system('mc cat ' . shellescape(full))
    new
    setlocal buftype=nofile bufhidden=hide noswapfile readonly
    call setline(1, split(content, "\n"))
  endif
endfunction

function! s:MinioGoUp() abort
  let parts = split(b:minio_path, '/')
  if len(parts) > 1
    call remove(parts, -1)
    let parent = join(parts, '/')
  else
    let parent = ''
  endif
  call s:OpenMinioBuffer(parent)
endfunction
