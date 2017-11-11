if &compatible
	set nocompatible
endif



"--------------------------------------------------
" encoding
"
" 内部文字コード
set encoding=utf-8
scriptencoding utf-8
" 読込み時の文字コード（fileencodingを設定していない場合、同じ値が使用される）
set fileencodings=utf-8,cp932,euc-jp



"--------------------------------------------------
" file
"
" バックアップファイル
set nobackup
" undoファイル
set undofile
set undodir=~/.vim/undodir
set viminfo+=n~/.vim/viminfo.txt
" 保存されていないファイルがあるときでも別のファイルを開くことができる
set hidden
" 外部でファイルが変更された場合は読み直す
set autoread



"--------------------------------------------------
" cursor
"
" 行頭行末移動ができるキー
set whichwrap=b,s,h,l
" バックスペースで消すことができる文字
set backspace=start,eol,indent



"--------------------------------------------------
" appearance
"
" カラースキーム
syntax on
if !has('gui_running')
	set t_Co=256
endif
set background=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme hybrid

" ハイライト
" 対応括弧
hi MatchParen term=standout cterm=bold gui=bold ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
" diff
hi DiffDelete ctermfg=lightmagenta guifg=lightmagenta

" フォント
set guifont=Ricty\ for\ Powerline:10h
set guifontwide=Ricty\ for\ Powerline:10h

" 行番号
set number
" カーソル行の強調
set cursorline
" 行間
set linespace=4
" 文章を画面幅で折り返し
set wrap
" 単語の途中で折り返さない
set linebreak
" 折り返しに文字数制限しない
set textwidth=0
" 折り返した2行目以降の文章もインデント
set breakindent
" 対応する括弧の強調
set showmatch

" インデント
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" インデントのスタイル
set cindent

" コマンドモードのタブ補完
set wildmenu
set wildmode=list:full
" コマンドラインの高さ
set cmdheight=1
" ステータスライン
set laststatus=2
set statusline=%F%<\ %m\ %r%=%l\ /\ %L
set noshowmode

" 2バイト文字の表示崩れを解消
set ambiwidth=double
" 文字の可視化
set list
set listchars=tab:\ \ ,eol:↲



"--------------------------------------------------
" search/replacement
"
" インクリメンタル検索
set incsearch
" 検索文字列の強調
set hlsearch
" 繰返し検索
set wrapscan
" 検索パターンにおいて大文字と小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 置換においてgを指定しなくても同一行で複数回置換
set gdefault



"--------------------------------------------------
" plugins
"
" dein
let s:dein_dir      = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:dein_toml     = expand('~/.vim/plugins.toml')

if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)
	call dein#load_toml(s:dein_toml)
	call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on

if dein#check_install()
	call dein#install()
endif



"--------------------------------------------------
" plugins option
"
" vim VimFiler
let g:vimfiler_as_default_explorer = 1

" neocomplate
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	" For no inserting <CR> key.
	return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
" Enable omni completion.
if has("autocmd")
	autocmd FileType css setlocal           omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal    omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal        omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal           omnifunc=xmlcomplete#CompleteTags
endif

" lightline.vim
let g:lightline = {
	\ 'colorscheme': 'nord',
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
	\ 	'right': [ [ 'lineinfo' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'inactive': {
	\ 	'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
	\ 	'right': [ [ 'lineinfo' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'component_function': {
	\ 	'modified':     'LightlineModified',
	\ 	'readonly':     'LightlineReadonly',
	\ 	'fugitive':     'LightlineFugitive',
	\ 	'lineinfo':     'LightlineLineinfo',
	\ 	'filename':     'LightlineFilename',
	\ 	'fileformat':   'LightlineFileformat',
	\ 	'filetype':     'LightlineFiletype',
	\ 	'fileencoding': 'LightlineFileencoding',
	\ 	'mode':         'LightlineMode',
	\ },
	\ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
	\ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
	\ }

function! LightlineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '\u2b64' : ''
endfunction

function! LightlineFugitive()
	try
		if expand('%:t') !~? 'Tagbar\|Gundo\' && &ft !~? 'vimfiler' && exists('*fugitive#head')
			let branch = fugitive#head()
			return 50 < winwidth(0) ? (branch !=# '' ? "\u2b60".branch : '') : ''
		endif
	catch
	endtry
	return ''
endfunction

function! LightlineLineinfo()
	let cl = line(".")
	let ll = line("$")
	let cc = col(".")
	let li = printf("%d/%d:%3d", cl, ll, cc)
	return 70 < winwidth(0) ? "\u2b61" . li : ''
endfunction

function! LightlineFilename()
	let fpath = expand('%:p')
	return fpath =~ '__Gundo' ? '' :
		\ &ft == 'vimfiler' ? vimfiler#get_status_string() :
		\ &ft == 'unite' ? unite#get_status_string() :
		\ &ft == 'vimshell' ? vimshell#get_status_string() :
		\ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
		\ ('' != fpath ? fpath : '[No Name]') .
		\ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
	return 70 < winwidth(0) ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return 70 < winwidth(0) ? (&filetype !=# '' ? &filetype : 'No FT') : ''
endfunction

function! LightlineFileencoding()
	return 70 < winwidth(0) ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
	let fname = expand('%:t')
	return fname == '__Gundo__' ? 'Gundo' :
		\ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
		\ &ft == 'unite' ? 'Unite' :
		\ &ft == 'vimfiler' ? 'VimFiler' :
		\ &ft == 'vimshell' ? 'VimShell' :
		\ 20 < winwidth(0) ? lightline#mode() :
		\ lightline#mode() == 'NORMAL' ? 'N' :
		\ lightline#mode() == 'INSERT' ? 'I':
		\ lightline#mode() == 'VISUAL' ? 'V' :
		\ lightline#mode() == 'V-LINE' ? 'VL' :
		\ lightline#mode() == 'V-BLOCK' ? 'VB' :
		\ lightline#mode() == 'REPLACE' ? 'R' : ''
endfunction

" easy-motion
let g:EasyMotion_do_mapping=0
let g:EasyMotion_smartcase=1

" vim-multiple-cursors
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
	if exists(':NeoCompleteLock')==2
		exe 'NeoCompleteLock'
	endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
	if exists(':NeoCompleteUnlock')==2
		exe 'NeoCompleteUnlock'
	endif
endfunction

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
if has("autocmd") && !has('gui_starting')
	let g:indent_guides_auto_colors=0
	let g:indent_guides_guide_size=1
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgray guibg=darkgray
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=gray     guibg=gray
endif

" emmet-vim
let g:user_emmet_leader_key = '<C-e>'
let g:user_emmet_settings = {
	\	'variables': {
	\		'lang': "ja"
	\	}
	\ }



"--------------------------------------------------
" mapping
"
let mapleader = "\<Space>"
nnoremap <Space> <Nop>
nnoremap <BS> <Nop>
nnoremap <CR> <Nop>
nnoremap <C-h>      :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>
nnoremap j gj
nnoremap k gk
nnoremap u g-
nnoremap <C-r> g+
nnoremap > >>
nnoremap < <<
nnoremap n nzz
nnoremap N Nzz
nnoremap <silent><Esc><Esc> :<C-u>noh<CR>
nnoremap <Leader>u :Unite<Space>
nnoremap <silent><Leader>s :<C-u>VimShell<CR>
nnoremap <silent><Leader>g :<C-u>GundoToggle<CR>

" easy-motion
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
nmap <Leader>s <Plug>(easymotion-overwin-f2)
map  <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

command! Q q!
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
inoremap <C-t> <Nop>
inoremap <C-d> <Del>
inoremap <C-h> <BS>

" us keyboard
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
vnoremap , <gv
vnoremap < ,
vnoremap . >gv
vnoremap > .



"--------------------------------------------------
" other
"
" カーソル位置の記憶
if has("autocmd")
	augroup redhat
		autocmd BufReadPost *
		\   if 0 < line("'\"") && line ("'\"") <= line("$") |
		\       exe "normal! g'\"" |
		\   endif
	augroup END
endif

" 全角スペースの可視化
if has("autocmd")
	highlight ZenkakuSpace cterm=underline ctermbg=darkred guibg=darkred
	autocmd BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
	autocmd WinEnter    * let w:m3 = matchadd("ZenkakuSpace", '　')
endif

" ペースト時インデントが階段状にならないようにする
if &term =~ "xterm"
	let &t_SI .= "\e[?2004h"
	let &t_EI .= "\e[?2004l"
	let &pastetoggle = "\e[201~"

	function! XTermPasteBegin(ret)
		set paste
		return a:ret
	endfunction

	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" マウスの有効化
if has('mouse')
	set mouse=a
	if has('mouse_sgr')
		set ttymouse=sgr
	elseif 703 < v:version || v:version is 703 && has('patch632')
		set ttymouse=sgr
	else
		set ttymouse=xterm2
	endif
endif

set secure
