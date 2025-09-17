" vim-test mappings
nmap <silent> <leader>gt :TestFile<CR>
nmap <silent> <leader>gs :TestSuite<CR>
nmap <silent> <leader>gl :TestLast<CR>
nmap <silent> <leader>gn :TestNearest<CR>

" Use pytest and a terminal strategy that fits our splits
let test#python#runner = 'pytest'
let test#strategy = 'vimterminal'
