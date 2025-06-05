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
