if exists('g:loaded_smartgf')
    finish
endif
let g:loaded_smartgf = 1

" Default suffixes if not set by user
let g:smartgf_suffixes = get(g:, 'smartgf_suffixes', ['.sql', '.py', '.js', '.jsx', '.ts', '.tsx', '.json', '.css', '.md'])

" Add suffixes to Vim's path
execute 'set suffixesadd+=' . join(g:smartgf_suffixes, ',')
set path+=**

function! s:SmartGfHandler(channel, msg)
    let found_files = split(a:msg, '\n')
    if len(found_files) == 1
        execute 'edit ' . found_files[0]
    elseif len(found_files) > 1
        cexpr found_files
        copen
    else
        echoerr "No files found matching: " . g:last_word
    endif
endfunction

function! s:SmartGf()
    let g:last_word = expand('<cfile>')
    silent! normal! gf
  
    if !filereadable(expand('<cfile>'))
        let cmd = ['find', '.', '-type', 'f', '-name', g:last_word . '.*']
        let job = job_start(cmd, {'callback': 's:SmartGfHandler'})
    endif
endfunction

" Define <Plug> mapping
nnoremap <silent> <Plug>(SmartGf) :call <SID>SmartGf()<CR>

" Default mapping if user hasn't disabled it
if !hasmapto('<Plug>(SmartGf)', 'n') && get(g:, 'smartgf_no_default_mapping', 0) == 0
    nmap gf <Plug>(SmartGf)
endif
