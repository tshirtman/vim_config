if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

"" completion etc
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-apathy'
Plug 'psf/black'
Plug 'fisadev/vim-isort'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" other language support
Plug 'vim-python/python-syntax'
Plug 'anntzer/vim-cython'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-swap'
Plug 'towolf/vim-helm'
Plug 'git@gitlab.trading.imc.intra:gpettier/vim-valescom'
Plug 'cespare/vim-toml'
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-jdaddy'
Plug 'mgedmin/coverage-highlight.vim'

"" style
" Plug 'chriskempson/base16-vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}

"" file management
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-eunuch'

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
Plug 'mbbill/undotree'

"" DB management
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

call plug#end()
