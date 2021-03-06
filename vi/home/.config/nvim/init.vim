set nocompatible

filetype off
call plug#begin("/home/dodo/.config/nvim/plugged")
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
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

" CoC key bindings

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

if has('patch8.1.1068')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
