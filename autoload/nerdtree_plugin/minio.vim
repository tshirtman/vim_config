" autoload/nerdtree_plugin/minio.vim

let s:proto = {}

function! nerdtree_plugin#minio#CreateMinioNode(path) abort
  let node = deepcopy(s:proto)
  let node.path = a:path
  let node.name = fnamemodify(a:path, ':t')
  let node.isDirectory = 1
  let node.getChildren = function('nerdtree_plugin#minio#GetChildren')
  let node.read = function('nerdtree_plugin#minio#ReadNode')
  return node
endfunction

function! nerdtree_plugin#minio#GetChildren(node) abort
  " You can call mc alias list or mc ls here and build children
  return []
endfunction

function! nerdtree_plugin#minio#ReadNode(node) abort
endfunction
