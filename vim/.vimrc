" kan's .vimrc

set nocompatible " must be first!

set t_Co=256
colorscheme smyck
nnoremap j gj
nnoremap k gk
set expandtab
set shiftround
set autoindent
set backspace=indent,eol,start
set backup
set hidden
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nobackup
set number " show the line number
set ruler
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set tabstop=4
set wrapscan
autocmd CursorHold * update
set updatetime=500
set autochdir

set fileencodings=utf-8,utf-16,euc-jp,iso-2022-jp,utf-8,cp932,utf-16
set fileformats=unix,dos,mac
if exists('&ambiwidth')
  set ambiwidth=double
endif

syntax on

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBuffs = 1

map ,pt <Esc>:%! perltidy<CR>
map ,ptv <Esc>:'<,'>! perltidy<CR>

autocmd BufNewFile,BufRead *.psgi   set filetype=perl
autocmd BufNewFile,BufRead *.t      set filetype=perl
autocmd BufNewFile,BufRead *.sbt set filetype=scala

au BufNewFile,BufRead *.html set shiftwidth=2 tabstop=2 softtabstop=2
au BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4

set nocompatible

" vim-plug automatic installation 
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"

Plug 'bling/vim-airline'

Plug 'hotchpotch/perldoc-vim', { 'for': 'perl' }
Plug 'vim-perl/vim-perl', { 'for': 'perl' }

Plug 'google/vim-ft-go', { 'for': 'go' }
Plug 'vim-jp/vim-go-extra', { 'for': 'go' }

Plug 'kien/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': './install.sh' }
let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
autocmd! User YouCompleteMe call youcompleteme#Enable()

call plug#end()

let g:user_zen_expandabbr_key = '<c-e>'

