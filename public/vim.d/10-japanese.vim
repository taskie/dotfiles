" vim/gvimで日本語を使いやすくする - fudist
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese

" カーソルを表示行で移動する。物理行移動は<C-n>, <C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" 日本語の行の連結時には空白を入力しない。
set formatoptions+=mM

" 画面最後の行をできる限り表示する。
set display+=lastline

" ファイルエンコーディングや文字コードをステータス行に表示する
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 

