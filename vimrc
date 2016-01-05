if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set number
set guifont=Consolas:h13:cANSI
colorscheme desert
"set background=dark

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

set guifont=Consolas:h13:cANSI   " 设置字体  

set autoread "文件被改动时自动录入
set autoindent "自动缩进"
set smartindent "自动缩进
set nobackup "不备份
set ignorecase  "搜索忽略大小写
set tabstop=4
set softtabstop=4
set shiftwidth=4


" 自动输入匹配的符号
" " map auto complete
 inoremap ( ()<esc>:let leavechar=")"<cr>i
 inoremap [ []<esc>:let leavechar="]"<cr>i
 inoremap { {<esc>o}<esc>:let leavechar="}"<cr>O
" inoremap { {}<esc>:let leavechar="}"<cr>i
 inoremap ' ''<esc>:let leavechar="'"<cr>i
 inoremap " ""<esc>:let leavechar='"'<cr>i
 au BufNewFile,BufRead *.\(vim\)\@! inoremap " ""<esc>:let leavechar='"'<cr>i
 au BufNewFile,BufRead *.\(txt\)\@! inoremap ' ''<esc>:let leavechar="'"<cr>i
 imap <m-l> <esc>:exec "normal f" . leavechar<cr>a
 imap <d-l> <esc>:exec "normal f" . leavechar<cr>

" 忽略重复键入的右括号
function! ParenClose()
 	let line = getline('.')
	let char = line[col('.')]

	if char == ')'
		execute "normal! l"
	else
		normal! a)
	end
endfunction
inoremap) <ESC>:call ParenClose()<CR>a

"
"在选中的文本两端添加(和]符号"
vnoremap ( l<ESC>:s/\%V\(.*\)\%V/\(\1\)/<CR>gv<ESC>:nohl<CR>
vnoremap [ l<ESC>:s/\%V\(.*\)\%V/\[\1\]/<CR>gv<ESC>:nohl<CR>s
" 选中添加符号
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
vnoremap ( l<ESC>:s/\%V\(.*\)\%V/\(\1\)/<CR>gv<ESC>:nohl<CR>
vnoremap [ l<ESC>:s/\%V\(.*\)\%V/\[\1\]/<CR>gv<ESC>:nohl<CR>
vnoremap { l<ESC>:s/\%V\(.*\)\%V/\{\1\}/<CR>gv<ESC>:nohl<CR>
vnoremap " l<ESC>:s/\%V\(.*\)\%V/\"\1\"/<CR>gv<ESC>:nohl<CR>

map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
let dir = getcwd()
    if filereadable("tags")
		if(g:iswindows==1)
			let tagsdeleted=delete(dir."\\"."tags")
		else
			let tagsdeleted=delete("./"."tags")
		endif

		if(tagsdeleted!=0)
			echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
			return
		endif
	endif
	if has("cscope")
	    silent! execute "cs kill -1"
	endif
	if filereadable("cscope.files")
		if(g:iswindows==1)
			let csfilesdeleted=delete(dir."\\"."cscope.files")
		else
			let csfilesdeleted=delete("./"."cscope.files")
		endif
		if(csfilesdeleted!=0)
			echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
			return
		endif
	endif
	if filereadable("cscope.out")
		if(g:iswindows==1)
			let csoutdeleted=delete(dir."\\"."cscope.out")
		else
			let csoutdeleted=delete("./"."cscope.out")
		endif
		if(csoutdeleted!=0)
			echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
			return
		endif
	endif
	if(executable('ctags'))
		"silent! execute "!ctags -R --c-types=+p --fields=+S *"
		silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
	endif
	if(executable('cscope') && has("cscope") )
		if(g:iswindows!=1)
			silent!  execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
		else
			silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
		endif
		silent! execute "!cscope -b" 
		execute "normal :"
		if filereadable("cscope.out")
			execute "cs add cscope.out"
		endif
	endif
endfunction

"进行Tlist的设置
""TlistUpdate可以更新tags
map <F3> :silent! Tlist<CR> "按下F3就可以呼出了
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0

execute pathogen#infect()

" 设置NerdTree
map <C-n> :NERDTreeMirror<CR>
map <C-n> :NERDTreeToggle<CR>


 

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=0
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler_options = '-std=c++11'


