" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/mru.vim'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

"https://github.com/terryma/vim-multiple-cursors
Plug 'terryma/vim-multiple-cursors'

"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

Plug 'ycm-core/YouCompleteMe'
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }

Plug 'altercation/vim-colors-solarized'

Plug 'scrooloose/nerdcommenter'

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

""" 在 Normal 模式下, 敲 <leader>jd 跳转到定义或声明(支持跨文件)
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'rust' : ['.', '::', 're!\w{3}'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

let g:ycm_filetype_whitelist = { 
			\ "c":1,
			\ "cpp":1, 
			\ "objc":1,
			\ "sh":1,
			\ "zsh":1,
			\ "rust":1,
			\ }
let g:syntastic_error_symbol = '>>'
let g:syntastic_warning_symbol = '!'

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


""""""""""""""""""""""""""""""""""""""""""""
""  LeaderF  "" 
""""""""""""""""""""""""""""""""""""""""""""
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_WorkingDirectoryMode = 'ac'
let g:Lf_WildIgnore = {'dir': ['target'], 'file': [ '*.lib', '*.dll','*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.bin']}


""""""""""""""""""""""""""""""""""""""""""""
"" NERDTree config ""
""""""""""""""""""""""""""""""""""""""""""""
map <F3> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"  "第一条是说使用F3键快速调出和隐藏它；
"  "第二条是关闭vim时，如果打开的文件除了NERDTree没有其他文件时，它自动关闭，减少多次按:q!。
"  "如果想打开vim时自动打开NERDTree，可以如下设定
"  autocmd vimenter * NERDTree
"---------------------------------------------------------------
