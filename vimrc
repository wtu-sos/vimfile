set nobackup        " no backup files
set nowritebackup   " no backup file while editing
set noswapfile      " no swap files
set undofile        " save undo's after file closes

if has('win32') || has ('win64')
  let $VIMHOME = $HOME."/vimfiles"
else
  let $VIMHOME = $HOME."/.vim"
endif

set nu
set tabstop=4
set cindent shiftwidth=4
set incsearch
set hlsearch
set encoding=utf-8

source $VIMHOME/plugins.vim

