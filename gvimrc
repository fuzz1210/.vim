"--------------------------------------------------
" window
"
" フルスクリーン
" set fuoptions=maxvert,maxhorz
" autocmd GUIEnter * set fullscreen

" GUIウィンドウの外観を無効化
if has("gui")
  set guioptions=r
  set guioptions=R
  set guioptions=l
  set guioptions=L
  set guioptions=T
  set guioptions=e
  set guioptions=g
endif

"--------------------------------------------------
" appearance
"
" フォント
set guifont=Ricty\ for\ Powerline:h18
set guifontwide=Ricty\ for\ Powerline:h18
