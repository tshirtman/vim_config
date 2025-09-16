" " File: ~/.vim/plugin/nerdtree_minio.vim
" "

" " plugin/nerdtree_minio.vim

" if exists("g:loaded_nerdtree_minio")
"   finish
" endif
" let g:loaded_nerdtree_minio = 1

" if exists("g:NERDTree") || &runtimepath =~# 'nerdtree'
"   call nerdtree#loadPlugin('minio')
" endif


" command! NERDTreeMinio call s:OpenMinioRoot()

" function! s:OpenMinioRoot()
"   execute 'NERDTree'
"   let node = nerdtree_plugin#minio#CreateMinioNode('minio://')
"   call g:NERDTreeRoot.setRoot(node)
"   call g:NERDTree.render()
" endfunction
