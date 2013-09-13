syntax on
filetype plugin indent on

"no \n at the end of file
set binary
set noendofline

autocmd FileType python inoremap . .<C-X><C-O><C-P>

set encoding=utf-8
set fileencodings=utf-8,gbk,gb2312,gb18030,ucs-bom,cp936,latin1
set termencoding=utf-8
set hlsearch "hilight search
"Colors
colorscheme murphy
"no vi mode
set nocompatible
"show row number
set nu
"set the width of tab
set tabstop=4
"set fonts
set guifont=Monaco:h12
"set indent
set cindent
set noet
set sw=4
""set Tlist
let Tlist_Process_File_Always = 1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Exit_OnlyWindow=1
let Tlist_WinWidth=24
"set h,l to next line
set whichwrap=b,s,<,>,[,]
"set fold type
""set fdm=indent
"NERD Tree
let NERDChristmasTree=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=20
nnoremap <F1> <C-w>h
nnoremap <F2> <C-w>j
nnoremap <F3> <C-w>k
nnoremap <F4> <C-w>l
nnoremap == gg=G
nnoremap <F9> :vsplit<Space><bar><Space>ta<Space>
"MiniBuffer
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 
"winmanager
let g:winManagerWindowLayout = "BufExplorer|FileExplorer|TagList"
let g:winManagerWidth = 20
nmap <silent>f :WMToggle<cr>

if has("cscope")
	set csprg=/usr/local/bin/cscope
	set csto=0
	set cst
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>

:inoremap ( ()<Esc>i
:inoremap {<CR> {}<Esc>i<CR><Up><ESC>A<CR>
:inoremap [ []<Esc>i
:inoremap " ""<Esc>i
:inoremap ' ''<Esc>i

function! Open_NERDTree()
	""	exe "normal 1G"
	exe ":NERDTree"
	exe ":Tlist"
endfunction
""autocmd VimEnter * call Open_NERDTree()

set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=R
set guioptions-=r
set guioptions-=b

map <F5> :call Do_OneFileMake()<CR>
function Do_OneFileMake()
	let sourcefilename=expand("%:t")
	if (sourcefilename=="" || (&filetype!="cpp" && &filetype!="c"))
		echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
		return
	endif
	let deletedspacefilename=substitute(sourcefilename,' ','','g')
	if strlen(deletedspacefilename)!=strlen(sourcefilename)
		echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
		return
	endif
	if &filetype=="c"
		set makeprg=gcc\ -o\ %<\ %
	elseif &filetype=="cpp"
		set makeprg=g++\ -o\ %<\ %
	endif
	let outfilename=substitute(sourcefilename,'\(\.[^.]*\)','','g')
	let toexename=outfilename
	execute "silent make"
	set makeprg=make
	execute "normal :"
	if filereadable(outfilename)
		execute "!./".toexename
	endif
	execute "copen"
	execute "!rm ./".toexename
endfunction
"set make
map <F6> :call Do_make()<CR>
map <c-F6> :silent make clean<CR>
function Do_make()
	set makeprg=make
	execute "silent make"
	execute "copen"
endfunction
