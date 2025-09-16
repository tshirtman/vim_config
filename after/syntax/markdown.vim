if exists("b:current_syntax")
  finish
endif

runtime! syntax/markdown.vim

" Needed to make syntax/sql.vim do something
unlet b:current_syntax

" Load SQL syntax
syntax include @Python syntax/python.vim

syn region PythonEmbedded contains=@Python contained
    \ start=+^```python+
    \ end=+^```+

let b:current_syntax = "mdpy"

highlight PythonEmbedded ctermfg=9
