set softtabstop=4
set shiftwidth=4
set expandtab
set list
set listchars=tab:——,trail:·

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


nnoremap <leader>CC :HighlightCoverageForAll<cr><cr>
nnoremap <leader>CO :HighlightCoverageOff<cr><cr>

match Error /(breakpoint)|(__import__('pudb').set_trace())|(assert .*assert.*)/

" map insecable space to space
inoremap   <space>
