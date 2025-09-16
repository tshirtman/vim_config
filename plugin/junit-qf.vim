function! PopulateQuickfixFromLastFailed(vert = v:false)
    " Read and parse the JSON file
    let l:json_file = expand('.pytest_cache/v/cache/lastfailed')
    let l:json_content = join(readfile(l:json_file), "\n")
    let l:data = json_decode(l:json_content)
    let l:items = []

    for l:key in keys(l:data)
        let l:file_path = matchstr(l:key, '^[^:]\+')
        let l:location = matchstr(l:key, '::\zs.\+\ze\%(\[.*\]\)\=')
        let l:extra_info = matchstr(l:key, '\[.*\]$')
        let l:text = l:location . l:extra_info
        if l:file_path != '' && l:location != ''
            call add(l:items, { 'filename': l:file_path, 'text': l:text, 'pattern': l:location })
        endif
    endfor

    if !empty(l:items)
        call setqflist(l:items, 'r')
        if a:vert == v:true
            vert copen
        else
            copen
        endif
        let b:pytest_quickfix = 1
    else
        echom "No failed tests found in lastfailed"
        call setqflist([], 'r')
        cclose
    endif
endfunction

function! RunPytestWithPattern(debug = v:false)
    let l:entry = getqflist({'idx': 0, 'items': 0})
    let l:idx = l:entry['idx']
    let l:item = l:entry['items'][l:idx - 1]
    let l:pattern = l:item['pattern']

    " Reuse the buffer or create a new terminal
    if l:pytest_window != -1
        execute l:pytest_window . 'wincmd w'
        " execute 'term ++cur pytest -k ' . l:pattern
        execute 'term ++curwin pytest ' . args . '-k ' . l:pattern
    else
        " simple way to focus qflist
        copen
        execute 'vertical Spawn pytest ' . args . '-k ' . l:pattern
        nnoremap <buffer> r :call RunPytestWithPattern()<CR>
        nnoremap <buffer> p :call RunPytestWithPatternDebug()<CR>
    endif

endfunction


function! RunPytestWithPatternDebug(in_place = v:null)
    let l:entry = getqflist({'idx': 0, 'items': 0})
    let l:idx = l:entry['idx']
    let l:item = l:entry['items'][l:idx - 1]
    let l:pattern = l:item['pattern']
    if a:in_place == v:true
        execute 'term ++curwin pytest --pdb -k' . l:pattern
    else
        execute 'vertical Spawn pytest -s --pdb -k ' . l:pattern
        nnoremap <buffer> r :bd\|call RunPytestWithPattern(v:true)<CR>
        nnoremap <buffer> p :bd\|call RunPytestWithPatternDebug(v:true)<CR>
    endif
endfunction

augroup QuickfixPytestBinding
    autocmd!
    autocmd FileType qf if get(b:, 'pytest_quickfix', 0) | nnoremap <buffer> r :call RunPytestWithPattern()<CR> | endif
    autocmd FileType qf if get(b:, 'pytest_quickfix', 0) | nnoremap <buffer> p :call RunPytestWithPattern(v:true)<CR> | endif
    autocmd FileType qf if get(b:, 'pytest_quickfix', 0) | nnoremap <buffer> R :PopulateQuickfixFromLastFailed<CR> | endif
augroup END

command! PopulateQuickfixFromLastFailed call PopulateQuickfixFromLastFailed()
command! VPopulateQuickfixFromLastFailed call PopulateQuickfixFromLastFailed(v:true)
