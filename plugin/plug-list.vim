if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

"" LSP + completion
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-apathy'
Plug 'psf/black', {'branch': 'stable'}
" Plug 'fisadev/vim-isort'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'TabbyML/vim-tabby'
Plug 'ggml-org/llama.vim'
" Plug 'gergap/vim-ollama'
" Plug 'vim-denops/denops.vim'
" Plug 'nekowasabi/aider.vim'
Plug 'puremourning/vimspector'
" Plug 'pasky/claude.vim'

" Plug 'Exafunction/windsurf.vim'

"" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" other language support
Plug 'vim-python/python-syntax'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'wellle/targets.vim'
Plug 'anntzer/vim-cython'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-swap'
Plug 'towolf/vim-helm'
Plug 'cespare/vim-toml'
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-jdaddy'
Plug 'mgedmin/coverage-highlight.vim'
Plug 'CarloDePieri/pytest-vim-compiler'
Plug 'vim-test/vim-test'
Plug 'jmcantrell/vim-virtualenv'
Plug 'GutenYe/json5.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'stephpy/vim-yaml'
Plug 'ekalinin/Dockerfile.vim'
Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'mvanderkamp/vim-pudb-and-jam'

"" style
" Base16 (tinted-theming successor)
Plug 'tinted-theming/tinted-vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-sleuth'

"" file management
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-eunuch'

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

"" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'jreybert/vimagit'
Plug 'idanarye/vim-merginal'
Plug 'mattn/vim-gist'
Plug 'mattn/webapi-vim'

"" misc
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-characterize'
" Plug 'mbbill/undotree'
Plug 'manasthakur/vim-asyncmake'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-dispatch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jlanzarotta/bufexplorer'
Plug 'tshirtman/vim-winny'
Plug 'zef/vim-cycle'
Plug 'markonm/traces.vim'
Plug 'diepm/vim-rest-console'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vimwiki/vimwiki'
Plug 'romainl/vim-qf'

" DB management
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

"" themes
Plug 'sickill/vim-monokai'

call plug#end()
