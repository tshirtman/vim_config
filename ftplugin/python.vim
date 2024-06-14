setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal list
setlocal listchars=tab:——,trail:·

match Todo 'NOTE'

lnoremap <leader>,b :Black<cr>
lnoremap <leader>,i :Isort<cr>
lnoremap <leader>,c :Black<cr>:Isort<cr>

let b:ale_python_pyright_config = {
  \ 'python': {
  \   'pythonPath': '~/.local/bin/python-shim',
  \   'venvPath': '~/.virtualenvs/',
  \ },
  \ 'pyright': {
  \   'disableLanguageServices': v:true,
  \ },
\}


nnoremap <silent> <leader>cc :HighlightCoverageForAll<cr>
nnoremap <silent> <leader>co :HighlightCoverageOff<cr>

match Error /(breakpoint)|(__import__('pudb').set_trace())|(assert .*assert.*)/

" map insecable space to space
inoremap   <space>

" lint
nmap <leader>,l :execute 'Black' \| Isort<cr>
