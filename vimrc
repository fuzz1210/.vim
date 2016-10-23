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
" バックアップファイル・キャッシュを作成しない
set nobackup
set noundofile
set viminfo=
" 保存されていないファイルがあるときでも別のファイルを開くことができる
set hidden
" 外部でファイルが変更された場合は読み直す
set autoread
" スペルチェック
set spell
set spelllang+=cjk



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
set t_Co=256
set background=dark
colorscheme hybrid
"colorscheme jellybeans
"colorscheme solarized
"let g:solarized_termcolors=256

" フォント
set guifont=Ricty:10h
set guifontwide=Ricty:10h

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
set cmdheight=2
" ステータスラインの常時表示
set laststatus=2
" ステータスラインに表示する内容
set statusline=%F%<\ %m\ %r%=%l\ /\ %L

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
" ESCキー2回押しでハイライトを解除
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>



"--------------------------------------------------
" plugins
"
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
" vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
if has("autocmd") && !has('gui_starting')
	let g:indent_guides_auto_colors=0
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=236
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=237
endif

" emmet-vim
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_settings={
\	'variables': {
\		'lang': "ja"
\	}
\}



"--------------------------------------------------
" keybind
"--------------------------------------------------
command Q q!
nnoremap j gj
nnoremap k gk
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap < <><Left>

" us keyboard
nnoremap ; :
nnoremap : ;
vnoremap , <
vnoremap < ,
vnoremap . >
vnoremap > .



"--------------------------------------------------
" other
"
" カーソル位置の記憶
if has("autocmd")
	augroup redhat
		autocmd BufReadPost *
		\ if line("'\"") > 0 && line ("'\"") <= line("$") |
		\   exe "normal! g'\"" |
		\ endif
	augroup END
endif

" 全角スペースの可視化
if has("autocmd")
	highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
	autocmd BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
	autocmd WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
endif

" ペースト時インデントが階段状にならないようにする
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
	let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
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
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
