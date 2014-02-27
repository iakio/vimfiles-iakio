scriptencoding utf-8

set nocompatible
filetype off

let s:is_win = has('win32') || has('win64')

if s:is_win
    let $MYVIMDIR = expand('~/vimfiles')
else
    let $MYVIMDIR = expand('~/.vim')
endif


"NeoBundle 'jceb/vim-hier'
"NeoBundle 'kana/vim-smartchr'
"NeoBundle 'thinca/vim-quickrun'
"NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mattn/sonictemplate-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tsaleh/vim-align'
NeoBundle 'vim-jp/vimdoc-ja'

NeoBundleLazy 'Blackrush/vim-gocode'     , {'autoload' : {'filetypes' : 'go'}}
NeoBundleLazy 'jdonaldson/vaxe'          , {'autoload' : {'filetypes' : 'haxe'}}
NeoBundleLazy 'kchmck/vim-coffee-script' , {'autoload' : {'filetypes' : 'coffee'}}
NeoBundleLazy 'othree/html5.vim'         , {'autoload' : {'filetypes' : ['html']}}


if $GOROOT != ''
    set rtp+=$GOROOT/misc/vim
    set rtp+=$MYVIMDIR/gocode/vim
endif

filetype plugin indent on
syntax on
let mapleader = " "

if filereadable('.vimrc.local')
    execute 'source .vimrc.local'
endif

if s:is_win
    set encoding=japan
    set fileencodings=euc-jp,utf-8
else
    set encoding=utf-8
endif

set ambiwidth=double
set backspace=indent,eol,start
set textwidth=0
set tabstop=4
set shiftwidth=4
set expandtab
set fileformats=unix,dos
set fileformat=unix
set laststatus=2
set hidden
set showcmd
set hlsearch
set completeopt=menu,menuone,preview
set shellslash
set visualbell
set wildmenu

if !has("gui_running")
    set t_Co=256
    let g:hier_highlight_group_qf = 'MatchParen'
    let g:hier_highlight_group_qfw = 'MatchParen'
    let g:hier_highlight_group_qfi = 'MatchParen'

    autocmd ColorScheme *
                \ highlight ListChars ctermbg=238
                \ | highlight SpecialKey ctermfg=29
                \ | highlight MatchParen cterm=underline ctermbg=0
                \ | highlight Pmenu ctermbg=238 ctermfg=11
                \ | highlight PmenuSel ctermfg=0 ctermbg=248
                \ | highlight link Tab ListChars
                \ | highlight link Trails Error

    autocmd Syntax * syntax match Tab containedin=ALL "\t"
    autocmd Syntax * syntax match Trails containedin=ALL "\s\+$"
    colorscheme desert256
endif


"
" mapping
"
nmap n nzz
nmap N Nzz
"nmap <C-n> :<C-u>cnext!<CR>zz
"nmap <C-p> :<C-u>cprevious!<CR>zz
nmap <Leader>v :<C-u>make %<CR>
nmap + <C-w>+
nmap - <C-w>-
nnoremap <C-l> :<C-u>nohls<CR><C-l>

imap <C-u> <Esc>
imap <C-l> <Esc>
cmap <C-l> <Esc>
vmap <C-l> <Esc>


function! s:au_lazzy()
    "
    " statusline
    "
    let &statusline="[%{bufnr('%')}]"
    let &statusline.="%<%f:"    " filename
    if exists('*cfi#format')
        let &statusline.="%{cfi#format('%s', '-')} "
    endif
    let &statusline.="%m%r%h%w%y"  " Modified, Readonly, Help, Preview, FileType
    let &statusline.="%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}"
    let &statusline.="%="       " Separation point
    let &statusline.="%l,%c"    " line number, column number
    let &statusline.="%V%8P"    " Virtual column number, Percentage
endfunction


function! s:try_utf8()
    if search("[^\x00-\x7f]", "nw") == 0 && &modifiable
        setlocal fileencoding=utf-8
    endif
endfunction


"
" autocmd
"
augroup MyGroup
    autocmd!
    autocmd VimEnter * call s:au_lazzy()
    autocmd FileType php compiler php
    autocmd FileType python setlocal softtabstop=4 expandtab
    autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType xhtml setlocal shiftwidth=2 softtabstop=2 expandtab
    autocmd BufNewFile,BufRead * call s:try_utf8()
    autocmd BufWritePost $MYVIMRC source %
augroup END


"
" default plugin
"
if !s:is_win
    runtime ftplugin/man.vim
endif
runtime macros/matchit.vim

"
" ChangeLog
"
let g:changelog_username = "ISHIDA Akio"


"
" sonictemplate
"
let g:sonictemplate_vim_template_dir = expand('$MYVIMDIR/bundle/vimfiles-iakio/template')
