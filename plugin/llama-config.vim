" put before llama.vim loads
" let g:llama_config = { 'show_info': 0 }
highlight llama_hl_hint guifg=#f8732e ctermfg=209
highlight llama_hl_info guifg=#50fa7b ctermfg=119
let g:llama_config = {
    \ 'endpoint':         'http://127.0.0.1:8012/infill',
    \ 'api_key':          '',
    \ 'n_prefix':         512,
    \ 'n_suffix':         128,
    \ 'n_predict':        128,
    \ 't_max_prompt_ms':  500,
    \ 't_max_predict_ms': 500,
    \ 'show_info':        1,
    \ 'auto_fim':         v:true,
    \ 'max_line_suffix':  8,
    \ 'max_cache_keys':   250,
    \ 'ring_n_chunks':    16,
    \ 'ring_chunk_size':  64,
    \ 'ring_scope':       1024,
    \ 'ring_update_ms':   1000,
    \ }
