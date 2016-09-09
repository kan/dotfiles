" *******************************************************************
" kan's .vimrc
"
" *******************************************************************

set nocompatible " must be first!

" -------------------------------------------------------------------
"  :PlugInstall  Install plugins
"  :PlugUpdate   Update plugins
"  :PlugClean    Remove unuse plugins
" -------------------------------------------------------------------

" -------------------------------------------------------------------
"  Basic settings
" -------------------------------------------------------------------

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
    set tabstop=4
    set wrapscan
    syntax on
    autocmd CursorHold * update
    set updatetime=500
    set autochdir
    set encoding=utf-8
    set fileencodings=utf-8,utf-16,euc-jp,iso-2022-jp,cp932
    set fileformats=unix,dos,mac
    set ambw=double
    set modeline
    set modelines=5
    set showtabline=2

    let g:miniBufExplMapWindowNavVim = 1
    let g:miniBufExplMapWindowNavArrows = 1
    let g:miniBufExplMapCTabSwitchBuffs = 1

" -------------------------------------------------------------------
"  plugins
" -------------------------------------------------------------------

    " vim-plug automatic installation 
    if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
    endif

    filetype off                           " required

    call plug#begin('~/.vim/plugged')

    Plug 'tpope/vim-fugitive'
    Plug 'itchyny/lightline.vim'

    Plug 'hotchpotch/perldoc-vim', { 'for': 'perl' }
    Plug 'vim-perl/vim-perl', { 'for': 'perl' }

    Plug 'google/vim-ft-go', { 'for': 'go' }
    Plug 'vim-jp/vim-go-extra', { 'for': 'go' }

    Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }

    Plug 'ctrlpvim/ctrlp.vim'

    Plug 'scrooloose/nerdtree'

    Plug 'clones/vim-l9'
    Plug 'othree/vim-autocomplpop'

    Plug 'mkitt/tabline.vim'

    Plug 'bronson/vim-trailing-whitespace'

    Plug 'elixir-lang/vim-elixir'

    call plug#end()
    filetype plugin indent on

" -------------------------------------------------------------------
"  color
" -------------------------------------------------------------------

    set t_Co=256
    set background=dark

    colorscheme iceberg

" -------------------------------------------------------------------
"  perl
" -------------------------------------------------------------------

    autocmd BufNewFile,BufRead cpanfile set filetype=cpanfile syntax=perl.cpanfile
    autocmd BufNewFile,BufRead *.psgi   set filetype=perl
    autocmd BufNewFile,BufRead *.t      set filetype=perl

    " perltidy
    map ,pt <Esc>:%! perltidy -se<CR>
    map ,ptv <Esc>:'<,'>! perltidy -se<CR>

" -------------------------------------------------------------------
"  golang
" -------------------------------------------------------------------

    au BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4

" -------------------------------------------------------------------
"  html
" -------------------------------------------------------------------

    au BufNewFile,BufRead *.html set shiftwidth=2 tabstop=2 softtabstop=2

" -------------------------------------------------------------------
"  ctrlp
" -------------------------------------------------------------------

    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlPMixed'

	if executable('ag')
        let g:ctrlp_use_caching = 0
        let g:ctrlp_user_command = 'ag -l -i --nocolor --nogroup --hidden --ignore .git -g "" %s'        " MacOSX/Linux
    endif

    let g:ctrlp_max_depth = 10
    let g:ctrlp_clear_cache_on_exit = 1

    set wildignore+=*/build/**
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class

    let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn|gradle)|target|blib)$',
    \ 'file': '\.(exe|so|dll|class)$',
    \ }

    " Guess vcs root dir
    let g:ctrlp_working_path_mode = 'ra'
    " Open new file in current window
    let g:ctrlp_open_new_file = 'r'

    let g:ctrlp_extensions = ['tab', 'quickfix', 'dir', 'line', 'mixed']
    let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'

" -------------------------------------------------------------------
"  tab setting
" -------------------------------------------------------------------

    nnoremap [Tab] <Nop>
    nmap t [Tab]

    for n in range(1, 9)
        execute 'nnoremap <silent> [Tab]'.n n.'gt'
    endfor

    nnoremap [Tab]j :tabnext<CR>
    nnoremap [Tab]k :tabprev<CR>
    nnoremap [Tab]e :tabedit<Space>
    nnoremap [Tab]x :tabclose<CR>

    autocmd VimEnter * tab all
    autocmd BufAdd * execute 'tablast | tabedit "'.expand('<afile').'"'

" -------------------------------------------------------------------
"  lightline setting
" -------------------------------------------------------------------
    let g:lightline = {
            \ 'colorscheme': 'seoul256',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'fugitive', 'readonly', 'filename', 'modified'] ]
            \ },
            \ 'component': {
            \   'readonly': '%{&filetype=="help"?"":&readonly?"×":""}',
            \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
            \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
            \ },
            \ 'component_visible_condition': {
			\   'readonly': '(&filetype!="help"&& &readonly)',
			\   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
			\   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
			\ },
            \ 'subseparator': { 'left': '＞', 'right': '＜' }
			\ }

