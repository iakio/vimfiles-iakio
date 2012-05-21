scriptencoding utf-8

set nocompatible
filetype off

let s:is_win = has('win32') || has('win64')

if s:is_win
	let $MYVIMDIR = expand('~/vimfiles')
else
	let $MYVIMDIR = expand('~/.vim')
endif

if has('vim_starting')
	set runtimepath +=$MYVIMDIR/bundle/neobundle.vim/
	call neobundle#rc(expand('$MYVIMDIR/bundle'))
endif

"NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'jceb/vim-hier'
"NeoBundle 'kana/vim-smartchr'
"NeoBundle 'kchmck/vim-coffee-script'
"NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mattn/sonictemplate-vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'vim-scripts/desert256.vim'
NeoBundle 'iakio/vimfiles-iakio'

syntax on
filetype plugin indent on
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
set noexpandtab
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

if has("gui_running")
	set gfn=Migu_1M:h10:cSHIFTJIS

	autocmd ColorScheme *
				\   highlight link Tab Folded
				\ | highlight link Trails Error

	autocmd Syntax * syntax match Tab containedin=ALL "\t"
	autocmd Syntax * syntax match Trails containedin=ALL "\s\+$"

	colorscheme desert
else
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
nmap <C-n> :<C-u>cnext!<CR>zz
nmap <C-p> :<C-u>cprevious!<CR>zz
nmap <Leader>v :<C-u>make %<CR>
nmap + <C-w>+
nmap - <C-w>-
nnoremap <C-l> :<C-u>nohls<CR><C-l>

imap Z{ {<CR>}<C-O>O
imap Z} {<CR>};<C-O>O
imap Z( ()<Left>
imap z[ []<Left>
imap Z' ''<Left>
imap z" ""<Left>

imap jj <Esc>
imap ;; ;<Esc>
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
" ctrl-p
"
let g:ctrlp_map = '<Leader>p'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*   " for Linux/MacOSX


"
" sonictemplate
"
let g:sonictemplate_vim_template_dir = expand('~/vimfiles/bundle/vimfiles-iakio/template')



if has('cscope')

	nnoremap <Leader>cs :<C-u>scs find s <C-R>=expand("<cword>")<CR><CR>
	nnoremap <Leader>cg :<C-u>scs find g <C-R>=expand("<cword>")<CR><CR>
	nnoremap <Leader>cc :<C-u>scs find c <C-R>=expand("<cword>")<CR><CR>
	nnoremap <Leader>ct :<C-u>scs find t <C-R>=expand("<cword>")<CR><CR>
	nnoremap <Leader>ce :<C-u>scs find e <C-R>=expand("<cword>")<CR><CR>
	nnoremap <Leader>cf :<C-u>scs find f <C-R>=expand("<cword>")<CR><CR>
	set cscopetagorder=0 cscopequickfix=s-,c-,i-,t-,e- nocscopetag
	if cscope_connection() == 0 && filereadable('cscope.out')
		cscope add cscope.out
	endif
	" setlocal nocscopeverbose
endif

