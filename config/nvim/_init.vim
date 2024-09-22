if filereadable(expand('~/.config/nvim/dein.vim'))
  source ~/.config/nvim/dein.vim
endif

" ========
" 全般
" ========
set number
set showmode
set showmatch
" 起動時のメッセージ非表示
set shortmess+=I
set nobackup
set noswapfile
set noundofile
set mouse=a

" ========
" キーバインド
" ========
" C-cをEscの代わりにする
inoremap <C-c> <ESC>

" ========
" 外観
" ========
colorscheme molokai
