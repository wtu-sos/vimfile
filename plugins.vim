" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/mru.vim'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'

"https://github.com/terryma/vim-multiple-cursors
Plug 'terryma/vim-multiple-cursors'

"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

Plug 'ycm-core/YouCompleteMe'
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }

Plug 'altercation/vim-colors-solarized'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""
"" color scheme setting ""
""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""
"" YouCompleteMe Setting ""
""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_rust_src_path = "~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"
let g:ycm_global_ycm_extra_conf = '~/.global_extra_conf.py'
nnoremap <silent> gd :YcmCompleter GoTo<CR>
nnoremap <silent> gv :YcmCompleter GetDoc<CR><C-w>k


""""""""""""""""""""""""""""""""""""""""""""
"" LanguageClient Setting ""
""""""""""""""""""""""""""""""""""""""""""""
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
	\}
let g:LanguageClient_trace = "off"
let g:LanguageClient_settingsPath = expand("~/.vim/settings.json")
"let g:LanguageClient_loggingFile = "/tmp/languageclien.log"
"let g:LanguageClient_loggingLevel = 'INFO'
"let g:LanguageClient_serverStderr = "/tmp/rls.log"
nnoremap <silent> <C-]> :call LanguageClient#textDocument_definition()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


""""""""""""""""""""""""""""""""""""""""""""
"" Lightline Setting ""
""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
set laststatus=2


