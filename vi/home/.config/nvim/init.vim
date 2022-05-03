set nocompatible

filetype off
call plug#begin("/home/dodo/.config/nvim/plugged")
Plug 'neovim/nvim-lspconfig'
Plug 'vim-scripts/taglist.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'wincent/command-t'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'junegunn/vim-peakaboo'
call plug#end()

filetype indent plugin on
syntax on

set background=dark
let g:solarized_termtrans="1"
colorscheme solarized

let g:clipboard = {
\  'name': 'chirp',
\  'cache_enabled': 1,
\  'copy': {
\    '+': 'chirp copy',
\    '*': 'chirp copy',
\  },
\  'paste': {
\    '+': 'chirp paste',
\    '*': 'chirp paste',
\  },
\}

set clipboard=unnamed,unnamedplus
set wildmenu
set backspace=indent,eol,start
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set startofline
set errorbells
set mouse=a
set ttyfast
set hidden
set updatetime=300

set splitbelow
set splitright

set hlsearch
set incsearch
set ignorecase
set smartcase

set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

set showcmd
set cmdheight=2
set title
set ruler
set number
set cursorline
set textwidth=80
set colorcolumn=+1,+41

set shortmess+=c

set nobackup
set nowritebackup

set undodir=/data/vim/undofiles
set undofile
set undolevels=10000

let g:mapleader=","

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap - :split<CR>
nnoremap \| :vsplit<CR>
nnoremap Q <nop>

autocmd FileType * set formatoptions-=t

autocmd BufNewFile,BufRead *.frb set syntax=ruby
autocmd BufNewFile,BufRead *.frb set filetype=ruby

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd vimenter * NERDTree | wincmd w
noremap  <C-n> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1

let g:ctrlp_user_command=[".git","cd %s && git ls-files -co --exclude-standard"]
let g:ctrlp_map="<C-e>"

lua << EOF
require'lspconfig'.gopls.setup{}
EOF

autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
