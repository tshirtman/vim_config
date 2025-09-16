setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal list
setlocal listchars=tab:——,trail:·

match Todo 'NOTE'

" nnoremap <leader>,b :silent !black % | redraw! <cr>
" nnoremap <leader>,i :silent !isort % | redraw! <cr>

let b:ale_python_pyright_config = {
  \ 'python': {
  \   'pythonPath': '~/.local/bin/python-shim',
  \   'venvPath': '~/.virtualenvs/',
  \ },
  \ 'pyright': {
  \   'disableLanguageServices': v:true,
  \ },
\}

if executable('python3')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'coverage_lsp',
        \ 'cmd': ['python3', '/Users/gpettier/dev/LSPyCoverage/main.py'],
        \ 'whitelist': ['python'],
        \ })
endif

highlight MissingCoverage ctermbg=243 ctermfg=NONE

" Define a custom function to handle diagnostic updates
function! MyDiagnosticUpdateHandler() abort
    " Clear previous highlights
    if exists('w:diagnostic_match_ids')
        for id in w:diagnostic_match_ids
            call matchdelete(id)
        endfor
    endif
    let w:diagnostic_match_ids = []

    " Get the URI of the current buffer
    let l:uri = lsp#utils#get_buffer_uri()

    " Get all diagnostics grouped by server for the current URI
    let l:diagnostics_by_server = lsp#internal#diagnostics#state#_get_all_diagnostics_grouped_by_server_for_uri(l:uri)

    " Check if the 'coverage_lsp' group exists and get its diagnostics
    if has_key(l:diagnostics_by_server, 'coverage_lsp')
        let l:coverage_diagnostics = l:diagnostics_by_server['coverage_lsp']['params']['diagnostics']

        " Highlight uncovered lines (example: highlight lines with the message 'Line not covered by tests')
        for l:diag in l:coverage_diagnostics
            if l:diag['message'] =~ 'Line not covered by tests'
                for line in range(l:diag['range']['start']['line'] + 1, l:diag['range']['end']['line'] + 1)
                    let id = matchadd('MissingCoverage', '\%' . l:line . 'l')
                    call add(w:diagnostic_match_ids, id)
                endfor
            endif
        endfor
    endif
endfunction

augroup OnLSP
    autocmd!
    autocmd User lsp_diagnostics_updated call MyDiagnosticUpdateHandler()
    autocmd User BufEnter call MyDiagnosticUpdateHandler()
    autocmd User BufWinEnter call MyDiagnosticUpdateHandler()
    autocmd User BufRead call MyDiagnosticUpdateHandler()
    autocmd User BufAdd call MyDiagnosticUpdateHandler()
augroup END



" Start LSP for Python files automatically
au FileType python setlocal omnifunc=lsp#complete


nnoremap <silent> <leader>cc :HighlightCoverageForAll<cr>
nnoremap <silent> <leader>co :HighlightCoverageOff<cr>

match Error /breakpoint()/

" map insecable space to space
inoremap   <space>

" lint
nmap <leader>,l :execute 'Black' \| Isort<cr>

function! s:PostMortem() abort
    " Get the current line
    let l:line = getline('.')
    " Insert "try:" before the line
    let l:line = 'try:' . l:line
    " Insert "except Exception as e:" after the line
    let l:line = l:line . 'except Exception as e:'
    " Insert "__import('pudb').post_mortem()" after the line
    let l:line = l:line . '__import(''pudb'').post_mortem()'
    " Replace the current line with the new line
    call setline('.', l:line)
endfunction

" these doesn't seem to be accounted for if from plugin
function! s:EchoError(msg) abort
    echohl Error
    echo a:msg
    echohl None
endfunction


" function! s:WrapInPudb() abort
"     " Save register and type
"     let l:old_reg = getreg('"')
"     let l:old_regtype = getregtype('"')

"     " Yank visual selection
"     normal! gv"zy
"     let l:lines = split(@z, "\n")

"     " Determine base indentation from the first non-empty line
"     for l:line in l:lines
"         if l:line =~ '\S'
"             let l:base_indent = matchstr(l:line, '^\s*')
"             break
"         endif
"     endfor

"     " Remove base indentation from each line before re-indenting
"     let l:cleaned_lines = map(l:lines, {idx, val -> substitute(val, '^' . l:base_indent, '', '')})

"     " Define inner indent (1 level deeper than base)
"     let l:inner_indent = l:base_indent . '    '

"     " Indent cleaned lines
"     let l:indented = map(l:cleaned_lines, {idx, val -> l:inner_indent . val})

"     " Wrap with try/except using base indent
"     let l:wrapped = [l:base_indent . 'try:'] + l:indented + [
"                 \ l:base_indent . 'except Exception as e:',
"                 \ l:base_indent . '    __import__("pudb").post_mortem()'
"                 \ ]

"     " Replace visual selection with new content
"     call setreg('"', join(l:wrapped, "\n"), l:old_regtype)
"     normal! gv""p

"     " Restore previous register
"     call setreg('"', l:old_reg, l:old_regtype)
" endfunction

function! s:WrapInPudb() abort
    " Save register and type
    let l:old_reg = getreg('"')
    let l:old_regtype = getregtype('"')

    " Yank the visual selection
    normal! gv"zy
    let l:lines = split(@z, "\n")

    " Check for existing debug wrapper
    let l:is_wrapped = len(l:lines) >= 5 &&
                \ l:lines[0] =~# '# >>> DEBUG_WRAPPER_START' &&
                \ l:lines[-1] =~# '# <<< DEBUG_WRAPPER_END'

    if l:is_wrapped
        " Unwrap: remove wrapper and un-indent inner code
        let l:unwrapped = l:lines[1:-2]

        let l:code_lines = []
        for l:line in l:unwrapped
            if l:line =~# '^\s*try:\s*$'
                continue
            elseif l:line =~# '^\s*except Exception as e:\s*$'
                continue
            elseif l:line =~# '^\s*__import__\("pudb"\).post_mortem()\s*$'
                continue
            endif

            " Remove one level of indentation (4 spaces or 1 tab)
            let l:dedented = substitute(l:line, '^\s\{4}', '', '')
            call add(l:code_lines, l:dedented)
        endfor

        call setreg('"', join(l:code_lines, "\n"), l:old_regtype)
        normal! gv""p
    else
        " Not wrapped: proceed to wrap it

        " Determine base indentation
        for l:line in l:lines
            if l:line =~ '\S'
                let l:base_indent = matchstr(l:line, '^\s*')
                break
            endif
        endfor

        let l:inner_indent = l:base_indent . '    '

        " Remove existing indent, then re-indent
        let l:cleaned_lines = map(l:lines, {idx, val -> substitute(val, '^' . l:base_indent, '', '')})
        let l:indented = map(l:cleaned_lines, {idx, val -> l:inner_indent . val})

        " Add markers + try/except
        let l:wrapped = [
                    \ l:base_indent . '# >>> DEBUG_WRAPPER_START',
                    \ l:base_indent . 'try:',
                    \ ] + l:indented + [
                    \ l:base_indent . 'except Exception as e:',
                    \ l:base_indent . '    __import__("pudb").post_mortem()',
                    \ l:base_indent . '# <<< DEBUG_WRAPPER_END'
                    \ ]

        call setreg('"', join(l:wrapped, "\n"), l:old_regtype)
        normal! gv""p
    endif

    " Restore previous register
    call setreg('"', l:old_reg, l:old_regtype)
endfunction

vmap <leader>pp :<C-u>call <SID>WrapInPudb()<CR>
