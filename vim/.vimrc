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

if $GOROOT != ''
    set rtp+=$GOROOT/misc/vim
end

" http://www.kawaz.jp/pukiwiki/?vim#content_1_5

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
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
autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl-script.txt
autocmd BufNewFile *.t  0r $HOME/.vim/template/perl-test.txt

autocmd! FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2

function! s:pm_template()
    set noautochdir
    let path = substitute(expand('%:p'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')

    call append(0, 'package ' . path . ';')
    call append(1, 'use Mouse;')
    call append(2, '')
    call append(3, '')
    call append(4, 'no Mouse;')
    call append(5, '__PACKAGE__->meta->make_immutable;')
    call append(6, '')
    call append(7, '1;')
    call cursor(3, 0)
    " echomsg path
    set autochdir
endfunction
autocmd BufNewFile *.pm call s:pm_template()

function! s:get_package_name()
    let mx = '^\s*package\s\+\([^ ;]\+\)'
    for line in getline(1, 5)
        if line =~ mx
        return substitute(matchstr(line, mx), mx, '\1', '')
        endif
    endfor
    return ""
endfunction

function! s:check_package_name()
    let path = substitute(expand('%:p'), '\\', '/', 'g')
    let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
    if path[-len(name):] != name
        echohl WarningMsg
        echomsg "ぱっけーじめいと、ほぞんされているぱすが、ちがうきがします!"
        echomsg "ちゃんとなおしてください><"
        echohl None
    endif
endfunction


au! BufWritePost *.pm call s:check_package_name()

nmap <Leader>r <plug>(quickrun)

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

