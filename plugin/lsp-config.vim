let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_highlights_enabled = 0

let g:lsp_diagnostics_signs_error = {'text': '❌'}
let g:lsp_diagnostics_signs_warning = {'text': '❔'}
let g:lsp_diagnostics_signs_information = {'text': '💁'}
let g:lsp_diagnostics_signs_hint = {'text': '🔍'}
let g:lsp_document_code_action_signs_hint = {'text': '🪛'}

let g:lsp_settings = {
\   'pylsp-all': {
\     'workspace_config': {
\       'pylsp': {
\         'configurationSources': ['flake8']
\       }
\     }
\   },
\}

if executable('ruff')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'ruff',
        \ 'cmd': {server_info->['ruff', 'server']},
        \ 'allowlist': ['python'],
        \ 'workspace_config': {},
        \ })
endif

" LSP keymaps
nmap <leader>dd :LspDocumentDiagnostics<cr>
nmap <silent> gd :LspDefinition<cr>
nmap <silent> gr :LspReferences<cr>
nmap <leader>rn :LspRename<cr>

" JDTLS workspace and repo setup
let g:vim_lsp_java = {
  \ 'eclipse_jdtls' : {
    \ 'repository': expand('~/dev/jdtls/'),
    \ 'config': 'config_linux',
    \ 'workspace': expand('$WORKSPACE'),
  \ },
\ }

" Optional popup scroll filter helpers
function s:popup_filter(winid, key) abort
  if a:key ==# get(g:, 'lsp_popup_scroll_down', "\<c-j>")
    call win_execute(a:winid, "normal! \<c-e>")
  elseif a:key ==# get(g:, 'lsp_popup_scroll_up', "\<c-k>")
    call win_execute(a:winid, "normal! \<c-y>")
  else
    return v:false
  endif
  return v:true
endfunction
