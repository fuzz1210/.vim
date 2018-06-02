if &compatible
    set nocompatible
endif

set secure

let mapleader = "\<Space>"



"--------------------------------------------------
" plugins
"
" dein
if v:version >= 704
    let s:dein_dir      = expand('~/.cache/dein')
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
    syntax enable

    if has('vim_starting') && dein#check_install()
        call dein#install()
    endif
endif



"--------------------------------------------------
" encoding
"
" 内部文字コード
set encoding=utf-8
scriptencoding utf-8
" 読込み時の文字コード
set fileencodings=utf-8,cp932,euc-jp



"--------------------------------------------------
" file
"
" バックアップファイル
set nobackup
" undoファイル
set undofile
set undodir=~/.vim/undo
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
if (v:version == 704 && has("patch1799")) || v:version >= 705
    set termguicolors
    colorscheme iceberg
else
    colorscheme hybrid
    highlight MatchParen ctermfg=green ctermbg=black guifg=green guibg=black
endif

" フォント
set guifont=Ricty\ for\ Powerline:h15
set guifontwide=Ricty\ for\ Powerline:h15

" 行番号
set number
set relativenumber
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
if (v:version == 704 && has("patch338")) || v:version >= 705
    set breakindent
endif
" 対応する括弧の強調
set showmatch

" インデント
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" インデントのスタイル
set cindent

" コマンドモードのタブ補完
set wildmenu
set wildmode=list:full
" ステータスライン
set laststatus=2
set statusline=%F%<\ %m\ %r%=%l\ /\ %L
set noshowmode

" 2バイト文字の表示崩れを解消
set ambiwidth=double
" 文字の可視化
set list
set listchars=eol:↲



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
" mapping
"
noremap <Space> <Nop>
noremap <BS> <Nop>
noremap <CR> <Nop>
nnoremap j gj
nnoremap k gk
nnoremap u g-
nnoremap <C-r> g+
nnoremap > >>
nnoremap < <<
nnoremap n nzz
nnoremap N Nzz

" ウィンドウ・タブページ
nnoremap s      <Nop>
nnoremap ss     :<C-u>split<CR>
nnoremap sv     :<C-u>vsplit<CR>
nnoremap sh     <C-w>h
nnoremap sj     <C-w>j
nnoremap sk     <C-w>k
nnoremap sl     <C-w>l
nnoremap sH     <C-w>H
nnoremap sJ     <C-w>J
nnoremap sK     <C-w>K
nnoremap sL     <C-w>L
nnoremap sr     <C-w>r
nnoremap s_     <C-w>_
nnoremap s<Bar> <C-w><Bar>
nnoremap s=     <C-w>=
nnoremap st     :<C-u>tabnew<CR>
nnoremap sn     gt
nnoremap sp     gT
nnoremap sw     :<C-u>w<CR>
nnoremap sq     :<C-u>q<CR>
nnoremap sx     :<C-u>x<CR>
nnoremap sz     ZZ
nnoremap sQ     :<C-u>q!<CR>

vnoremap < <gv
vnoremap > >gv
inoremap <C-h> <BS>
" inoremap <C-d> <Del>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
command! Q q!
" ヘルプ
nnoremap <C-h>      :<C-u>help<Space>
" カーソル位置のワードのヘルプ
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>
" 検索ハイライトの解除
nnoremap <silent><Esc><Esc> :<C-u>nohlsearch<CR>
" 行番号の絶対表示/相対表示の切替え
nnoremap <silent><F3> :set relativenumber!<CR>
" vimrcの再読込み
nnoremap <silent><F5> :source ~/.vimrc<CR>


"--------------------------------------------------
" other
"
" カーソル位置の記憶
"
if has("autocmd")
    augroup redhat
        autocmd!
        autocmd BufRead *
        \   if 0 < line("'\"") && line ("'\"") <= line("$") |
        \       exe "normal! g'\"" |
        \   endi
    augroup END
endif

" 特定の全角文字の可視化
if has("autocmd")
    augroup Zenkaku
        autocmd!
        autocmd WinEnter,BufWinEnter * let w:mnum = matchadd("Zenkaku", '[０１２３４５６７８９]')
        autocmd WinEnter,BufWinEnter * let w:malp = matchadd("Zenkaku", '[ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ]')
        autocmd WinEnter,BufWinEnter * let w:mALP = matchadd("Zenkaku", '[ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ]')
    augroup END
    highlight Zenkaku term=underline ctermbg=darkred guibg=darkred
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
