"Add stuff to our include path
set path+=/usr/include/linux

"set VIM=/usr/share/vim/vim72

"Turn off compatiblity
set nocompatible

set bs=2		" allow backspacing over everything in insert mode
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history

"Turn on word wrap for comments only
"set textwidth=80
set formatoptions=cqro

"turn on syntax highlighting 
:syntax on
" let c_space_errors=1
let c_expandtab=1
" For highlighted numbers:
let python_highlight_numbers = 1
" For highlighted builtin functions:
let python_highlight_builtins = 1
" For highlighted standard exceptions:
let python_highlight_exceptions = 1

"By default we don't want tabs, we want spaces
"set expandtab

"For faster switching between windows
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
"set wmh=0

filetype on

"Taglist stuff
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth=80

:set cscopequickfix=s-,c-,d-,i-,t-,e-

"make sure we don't turn off tabs for Makefiles
au FileType make setlocal noexpandtab

"开启minibuffer
let g:miniBufExplMapCTabSwitchBufs = 1
" 使用ctrl+箭头键切换vim中的窗口
let g:miniBufExplMapWindowNavArrows = 1 
" Python editing script

au FileType python source ~/.vim/scripts/python.vim

"these characters can move past end of line
set whichwrap=b,s,h,l

"feng add for ctags use
set tags=tags;
"set autochdir

"autoindent on
set ai

"Turn on wildmenu
set wildmenu

"Show command
set showcmd

"show matching bracket
set showmatch

colorscheme desert

" I always use vim against a black background.
if &term == "xterm"
	set background=light
else
	set background=dark
endif

" Set status
set ls=2

"use standard tab stop of 8
set ts=8   
" Use expand tabs for C & C++ files
"au BufReadPost,FileReadPost,BufNewFile * if exists( "b:current_syntax" )
"au BufReadPost,FileReadPost,BufNewFile *   if b:current_syntax == "c" || b:current_syntax == "cpp"
"au BufReadPost,FileReadPost,BufNewFile *     "use spaces to create a tab
"au BufReadPost,FileReadPost,BufNewFile *     set expandtab
"au BufReadPost,FileReadPost,BufNewFile *   endif
"au BufReadPost,FileReadPost,BufNewFile * endif

" Use expand tabs for Python files
au BufReadPost,FileReadPost,BufNewFile * if exists( "b:current_syntax" )
au BufReadPost,FileReadPost,BufNewFile *   if b:current_syntax =="python"
au BufReadPost,FileReadPost,BufNewFile *     "use spaces to create a tab
"au BufReadPost,FileReadPost,BufNewFile *     set expandtab
au BufReadPost,FileReadPost,BufNewFile *   endif
au BufReadPost,FileReadPost,BufNewFile * endif

"use softtabs of 4
set softtabstop=8

"use shiftwidth of 4
set shiftwidth=8

"When searching ignore that case but also use the smartcase feature
"set ignorecase
set smartcase

"Use incremental searching
set incsearch

"We want highlight search
set hlsearch

"replace globally, not the first match in the line
set gdefault

"Display the ruler
set ruler

"Make sure we keep 4 lines of text between the cursor and the
"top/bottom of page
set scrolloff=4

"Use the visual bell
set visualbell

hi Normal guifg=white guibg=black

let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth=35
let g:bufExplorerMaxHeight=10
nmap wm :WMToggle<cr>

"version number.
":version 5.2

"let bash_is_sh = 1
"let is_bash = 1

" The main changes I make to the colors is make Function a tad brighter so
" it's more readable. Also, I prefer darkcyan for my comments. I don't 
" like comments to be "louder" than the actual code.
" This is a hack of the color section in 
" /usr/local/share/vim/syntax/syntax.vim

  if &background == "dark"
    hi Comment      term=bold       ctermfg=LightGreen  guifg=#60ff60   gui=bold
    hi Constant	    term=underline  ctermfg=Magenta 	guifg=Magenta
    hi Special	    term=bold	    ctermfg=DarkMagenta	guifg=Red
    hi Identifier   term=underline  ctermfg=Cyan        cterm=bold	guifg=#40ffff
    hi Statement    term=bold	    ctermfg=Yellow	gui=bold	guifg=#aa4444 
    hi PreProc	    term=underline  ctermfg=LightBlue 	guifg=#ff80ff
"    hi Type	    term=underline  ctermfg=LightGreen 	guifg=#60ff60 gui=bold
    hi Type	    term=underline  ctermfg=Yellow 	guifg=Yellow gui=bold
    hi Function	    term=bold	    ctermfg=White	guifg=LightRed
    hi Repeat	    term=underline  ctermfg=White	guifg=LightRed
    hi Operator                     ctermfg=Red         guifg=Red
    hi Ignore			    ctermfg=black 	guifg=bg
    hi visual       cterm=bold       ctermfg=Yellow ctermbg=Red	guifg=yellow guibg=red
  else
    hi Comment  term=bold   ctermfg=DarkGreen  guifg=SeaGreen  gui=bold
    hi Constant	term=underline ctermfg=DarkRed guifg=Magenta
    hi Special	term=bold ctermfg=DarkMagenta guifg=SlateBlue
    hi Identifier term=underline ctermfg=DarkCyan guifg=DarkCyan
    hi Statement term=bold ctermfg=Brown gui=bold guifg=Brown
    hi PreProc	term=underline ctermfg=DarkMagenta guifg=Purple
    hi Type	term=underline ctermfg=DarkGreen guifg=SeaGreen gui=bold
    hi Ignore	ctermfg=white guifg=bg
  endif
  hi Error	term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White
  hi Todo	term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow

  " Common groups that link to default highlighting.
  " You can specify other highlighting easily.
  hi link String	Constant
  hi link Character	Constant
  hi link Number	Constant
  hi link Boolean	Constant
  hi link Float		Number
  hi link Conditional	Statement
  hi link Label		Statement
  hi link Keyword	Statement
  hi link Exception	Statement
  hi link Include	PreProc
  hi link Define	PreProc
  hi link Macro		PreProc
  hi link PreCondit	PreProc
  hi link StorageClass	Type
  hi link Structure	Type
  hi link Typedef	Type
  hi link Tag		Special
  hi link SpecialChar	Special
  hi link Delimiter	Special
  hi link SpecialComment Special
  hi link Debug		Special

if has("cscope")
       set csprg=/usr/bin/cscope
       set csto=1
       set cst
       set nocsverb
       " add any database in current directory
       if filereadable("cscope.out")
           cs add cscope.out
       endif
       set csverb
endif


function! UPDATE_TAGS()
	let _f_ = expand("%:p")
	let _cmd_ = '"ctags -a -f ~/ws2/projects/spi-dma-testing/tags --c++-kinds=+p --fields=+iaS --extra=+q " ' . '"' . _f_ . '"'
	let _resp = system(_cmd_)
	unlet _cmd_
	unlet _f_
	unlet _resp
endfunction
autocmd BufWrite *.cpp,*.h,*.c call UPDATE_TAGS()

"
" Cscope commands
" s: find C symbol
" c: who call this func
" d: what funcs are called by this func
" t: find this symbol
" f: find the file with this name
" i: find who includes this file
"
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Key map
" My own mapping setup
map t <C-w><C-w>
map c :colorscheme desert <CR>
map q :wqa<CR>
map w :w<CR>
map ta :sp<CR><C-]>
map tv :vsp<CR><C-]>
map tc :q<CR>

map tl o<CR>unsigned long flags;<CR>flags = irq_lock();<CR>irq_unlock(flags)<CR>


" goto the start of line and add mask for c/python language
map pc 0i#<ESC>
map cc 0i//<ESC>
map ucc 0xx<Esc>

map -- o<ESC>0a----------------------------------------------------------------<ESC>
map -> o<ESC>0a---------------------------------------------------------------->><ESC>
map -< o<ESC>0a----------------------------------------------------------------<<<ESC>

map == o===========================================================<ESC>

" new func
map nf o<Esc>i{<CR><CR>}<CR><ESC>kk0i<Tab> 
" new section if for()
map ni $a {<CR><CR>}<CR><ESC>kk0i<Tab> 

" define
map nd o#define 


map <F4> a<C-R>=strftime("%c")<CR><Esc>
map <F5> o{<CR><CR>}<CR><ESC>kk0i<Tab> 
map <F6> o/*<CR><CR>/<CR><ESC>kkla 
map st	0istatic <Esc>
map ex	0iextern <Esc>

" For Linux patch
"map sbob oSigned-off-by: Bob Moore <robert.moore@intel.com><Esc>
"map slen oSigned-off-by: Len Brown <len.brown@intel.com><Esc>
map sme oSigned-off-by: Feng Tang <feng.tang@intel.com><Esc>
map smb oSigned-off-by: Ben Widawsky <ben.widawsky@intel.com><Esc>
map sfb oFrom: Ben Widawsky <ben.widawsky@intel.com><Esc>
map ame oAcked-by: Feng Tang <feng.tang@intel.com><Esc>
map rme oReviewed-by: Feng Tang <feng.tang@intel.com><Esc>
map tro oTracked-On: https://jira.ndg.intel.com/browse/FIRE-<Esc>a
map cak oCc: Andrew Morton <akpm@linux-foundation.org><Esc>
map chy oCc: "Huang, Ying" <ying.huang@intel.com><Esc>
map shy oSuggested-by: "Huang, Ying" <ying.huang@intel.com><Esc>
map cgreg oCc: Greg Kroah-Hartman <gregkh@linuxfoundation.org><Esc>
map mi ompi();<Esc>
map mo ompo();<Esc>
map ei oetpi();<Esc>
map eo oetpo();<Esc>

map ml ompl();<Esc>
map m0 ompn(0);<Esc>
map m1 ompn(1);<Esc>
"map m2 ompn(2);<Esc>
map m3 ompn(3);<Esc>
map m4 ompn(4);<Esc>
map m5 ompn(5);<Esc>
map m6 ompn(6);<Esc>
map ow owhile (1);<Esc>

map m2i om2pi();<Esc>
map m2o om2po();<Esc>


map fi ofprintf(stderr, "%s(): enter\n", __func__);<Esc>
map fo ofprintf(stderr, "%s(): exit\n", __func__);<Esc>

"map m7 ompn(7);<Esc>
"map m8 ompn(8);<Esc>

map m7 opr_info("A", "%s(): enter: %s", __func__);<Esc>
map m8 opr_info("A", "%s(): exit: %s", __func__);<Esc>

map mti omtpi();<Esc>
map mto omtpo();<Esc>
"map eti oetpi();<Esc>
"map eto oetpo();<Esc>
map mp omp("<Esc>
map pkc <Esc>:%s/^...//g<CR><ESC>
map cb ocase    :<CR><Tab><CR>break;<Esc>kk
map fd ofirst_dump();<Esc>

"ap sca iACPICA: <Esc>
map sp <Esc>:set spell<Esc>
map if0 o#if 0<Esc>
map eni o#endif<Esc>

map e0 oecho "000000000000000000000000000"
map e1 oecho "111111111111111111111111111"
map e2 oecho "222222222222222222222222222"
map e3 oecho "333333333333333333333333333"
map e4 oecho "444444444444444444444444444"
map e5 oecho "555555555555555555555555555"
map e6 oecho "666666666666666666666666666"


map <F10> igallery-<Esc> 

" Cleanup the trail null space and tab
"map <F7> :%s/\t\{1,\}$//g<Esc>/<ESC>:%s/ \{1,\}$//g<Esc>
"map <F7> :%s/\t\+$//g<Esc>/<ESC>:%s/ \+//g<Esc>
"map <F8> :%s/ \{1,\}$//g<Esc>
map <F8> :%s/ \+$//g<Esc>

" Clean the code
"map <F7> :%s/[\t ]\+$//g<Esc>
map cl	 :%s/[\t ]\+$//g<Esc>

map <F9> :%s/^+\+//g<Esc>
map <F10> :%s/^.................//g<Esc> 

map u3 ou32 

map cw ologger.warning(
map ty oThanks,<CR>Feng

map ao a OK<Esc>
map as a Edit-Small<Esc>
map ah a Edit-Huge<Esc>
map ab a Edit-Big<Esc>
map ak a SKIP<Esc>

"map ln a__attribute__((aligned(64))) 


"map iis ainstruction supported
"map fp afeature present<Esc>

"map mk o$(warning <Esc>
"map vv ocheck_nand_cdc_inited();<CR><Esc>

" remove whole line with a keyword
" %s/^.*AUD.*$\n//g
