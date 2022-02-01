set softtabstop=4
set shiftwidth=4
set expandtab
set list
set listchars=tab:——,trail:·

match Todo 'NOTE'

nnoremap <leader>,b :Black<cr>

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

match "breakpoint()" Error
