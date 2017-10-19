syntax on
filetype plugin indent on

"no \n at the end of file
set binary
set noendofline

set cursorline        "突出显示当前行"
set cursorcolumn        "突出显示当前列"

autocmd FileType python,javascript,java inoremap . .<C-X><C-O><C-P>

"no preview window
:set completeopt-=preview

set encoding=utf-8
"set encoding=chinese
set fenc=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set hlsearch "hilight search
set list
set listchars=tab:\|\ ,
"Colors
set background=dark
let g:solarized_contrast="high"
if has('gui_running')
	colorscheme solarized
else
	colorscheme murphy
endif

"no vi mode
set nocompatible
"show row number
set nu
"set the width of tab
set ts=4
set noexpandtab
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
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_WinWidth=24
"set h,l to next line
set whichwrap=b,s,<,>,[,]
"set fold type
""set fdm=indent

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
"let g:winManagerWindowLayout = "BufExplorer|FileExplorer|TagList"
"let g:winManagerWindowLayout= "BufExplorer|NERDTree|TagList"
let g:winManagerWindowLayout = "NERDTree|TagList|BufExplorer"
let g:NERDTree_title="[NERDTree]"
let g:winManagerWidth = 20
nmap <silent>f :WMToggle<cr>

function! NERDTree_Start()  
    exec 'NERDTree'  
endfunction

function! NERDTree_IsValid()  
    return 1  
endfunction

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
":inoremap ' ''<Esc>i

inoremap <expr> <Tab> MyTab()
fun MyTab()
		let str=strpart(getline("."), 0, col(".")-1)
		if str!="" && str=~'\m\w$'
				return "\<C-N>"
		endif
		return "\t"
endfun

set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=R
set guioptions-=r
set guioptions-=b

map ` <leader>ci <CR>

"按F5运行python"
map <F5> :call RunPython()<CR>
function RunPython()
  let mp = &makeprg
  let ef = &errorformat
  let exeFile = expand("%:t")
  setlocal makeprg=python2\ -u
  set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  silent make %
  copen
  let &makeprg = mp
  let &errorformat = ef
endfunction

map <F6> :call Do_OneFileMake()<CR>
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

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

execute pathogen#infect()

:imap <S-Tab> <Plug>snipMateNextOrTrigger
:smap <S-Tab> <Plug>snipMateNextOrTrigger
