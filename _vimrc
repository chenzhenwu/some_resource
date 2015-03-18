"""""""""""""""""""""""""""""""""""""""""
"使用vundle管理插件
"""""""""""""""""""""""""""""""""""""""""
set nocompatible               " be iMproved
filetype off                   " required!
filetype plugin indent on     " required!
 
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
 
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
 
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'groenewege/vim-less'
Bundle 'davidhalter/jedi-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/Syntastic' 
Bundle 'terryma/vim-multiple-cursors'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-powerline' 
Bundle 'Yggdroot/indentLine'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'mfukar/robotframework-vim'

Bundle 'jlanzarotta/bufexplorer'
Bundle 'vim-scripts/taglist.vim'
Bundle 'ervandew/supertab'
Bundle 'mbbill/fencview'
Bundle 'fholgado/minibufexpl.vim'


" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'python.vim'





" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...

set expandtab
set nocompatible
map <F12> :!python.exe %
map <F11> :e g:\workspace\pydev
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set nobackup "取消自动备份
setlocal noswapfile "不产生交换文件

"set ffs=unix
set diffexpr=MyDiff()
function MyDiff()
 let opt = '-a --binary '
 if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
 if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
 let arg1 = v:fname_in
 if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
 let arg2 = v:fname_new
 if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
 let arg3 = v:fname_out
 if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
 silent execute '!D:/Vim/vim70/diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
endfunction

hi  HL_HiCurLine ctermfg=blue ctermbg=cyan guifg=blue guibg=cyan
let HL_HiCurLine= "HL_HiCurLine"

set formatoptions=tcrqn2
"set guifont=FixedsysTTF:h14   "如果没有这个字体那就不要加
" set guifont=YaHei\ Consolas\ Hybrid:h10	"
" set guifont=Microsoft_YaHei_Mono:h10.5 "
set guifont=Consolas:h10.5
set guifontwide=Microsoft\ Yahei\ Mono:h10.5
" set guifont=monaco:h10.5  "
" set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI "
" set guifont=Arial_monospaced_for_SAP:h9:cANSI "
" set gfw=幼圆:h10:cGB2312"
" set gfw=方正准圆简体:h9:cGB2312"
"colorscheme darkblue            "在gvim下可以看到有多少coloscheme
color desert

set lsp=0
set sw=4      " shiftwidth
set et        " expandtab
"set wm=8      " wrapmargin
set lbr       "不在单词中间断行
set fo+=mB    "打开断行模块对亚洲语言支持
set bs=2      " backspace
set ru        " ruler
set ic        " ignorecase      "忽略大小写 但是输入中有大写的话不忽略
set is        " incsearch
set scs       " smartcase: override the 'ic' when searching
"     if search pattern contains uppercase char

set wmnu
set wildignore=*.bak,*.o,*.e,*~

iab #i #include
iab #d #define
iab #e #endif

set cst
set csto=1
set tags=./tags,../tags,../../tags,../../../tags,D:/program/Python27/tags,d:/program/vim/vim74/tags
set cspc=3  " show file path's last three part

"set grepprg=grep/ -nH

map <F2>    :Tlist<cr>
"map <F2>    :WMToggle<cr>
"代码折叠快捷方式
map <F3>    zO
map <F4>    zc
map <F5>    zR
map <F6>    zM
"map <F7>    :cn<CR>

"   
set vb t_vb=  " set visual bell and disable screen flash


"下面是设置自动folder的 而且是根据写C代码设置的 如果你不喜欢使用folder那么可以省略掉
"au BufReadPost *.h,*.c,*.cpp,*.java,*.pl    syn region myFold start="{" end="}" transparent fold
"au BufReadPost *.h,*.c,*.cpp,*.java,*.pl    syn sync fromstart
"au BufReadPost *.h,*.c,*.cpp,*.java,*.pl    set foldmethod=syntax
"set foldlevel=0
set foldmarker={,}
set foldmethod=marker
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen-=search " don't open folds when you search into them
set foldopen-=undo " don't open folds when you undo stuff


"-------------------------------------------------------------------------------
" C-support.vim
"-------------------------------------------------------------------------------
let g:C_AuthorName   = 'J.T Jacky'
let g:C_AuthorRef    = ''
let g:C_Email        = 'brothertian@gmail.com'
let g:C_Company      = 'Baosight'

"-------------------------------------------------------------------------------
" C++
"-------------------------------------------------------------------------------
set sm
set cin
set cino=:0g0t0(sus

"-------------------------------------------------------------------------------
"   copy from web
"-------------------------------------------------------------------------------

set history=1000 " How many lines of history to remember
set cf " enable error files and error jumping
set clipboard+=unnamed " turns out I do like is sharing windows clipboard
set ffs=dos,unix,mac " support all three, in this order
filetype plugin on " load filetype plugins
set viminfo+=! " make sure it can save viminfo
set isk+=_,$,@,%,#,- " none of these should be word dividers, so make them not be

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set lsp=0 " space it out a little more (easier to read)
set wildmenu " turn on wild menu
set ruler " Always show current positions along the bottom
set cmdheight=1 " the command bar is 2 high
set number " turn on line numbers
set lz " do not redraw while running macros (much faster) (LazyRedraw)
"set hid " you can change buffer without saving
set backspace=2 " make backspace work normal
set whichwrap+=<,>,h,l  " backspace and cursor keys wrap to
set mouse=a " use mouse everywhere
set shortmess=atI " shortens messages to avoid 'press a key' prompt
set report=0 " tell us when anything is changed via :...
set noerrorbells " don't make noise
" make the splitters between windows be blank
"set fillchars=vert:/ ,stl:/ ,stlnc:/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Cues
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set showmatch " show matching brackets
"set mat=5 " how many tenths of a second to blink matching brackets for
"set nohlsearch " do not highlight searched for phrases
set incsearch " BUT do highlight as you type you search phrase
"set listchars=tab:/|/ ,trail:.,extends:>,precedes:<,eol:$ " what to show when I hit :set list
"set lines=80 " 80 lines tall
set columns=120 " 160 cols wide
"set so=10 " Keep 10 lines (top/bottom) for scope
set novisualbell " don't blink
set noerrorbells " no noises
set statusline=%F%m%r%h%w/[FORMAT=%{&ff}]/[TYPE=%Y]/[ASCII=/%03.3b]/[HEX=/%02.2B]/[POS=%04l,%04v][%p%%]/[LEN=%L]
set laststatus=2 " always show the status line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fo=tcrqn " See Help (complex)
"set ai " autoindent
"set si " smartindent
set cindent " do c-style indenting
filetype indent on
set tabstop=4 " tab spacing (settings below are just to unify it)
set softtabstop=4 " unify
set shiftwidth=4 " unify
"set noexpandtab " real tabs please!
set nowrap " do not wrap lines 
set guioptions+=b "添加水平滚动条
"set smarttab " use tabs at the start of a line, spaces elsewhere

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"    Enable folding, but by default make it act like folding is off, because folding is annoying in anything but a few rare cases
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable " Turn on folding
set foldmethod=indent " Make folding indent sensitive
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen-=search " don't open folds when you search into them
set foldopen-=undo " don't open folds when you undo stuff

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Explorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:explVertical=1 " should I split verticially
let g:explWinSize=20 " width of 35 pixels

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Win Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWidth=20 " How wide should it be( pixels)
let g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer' " What windows should it

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = 'D:/program/Vim/vim74/ctags.exe' " Location of ctags
let Tlist_Sort_Type = "name" " order by
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_Compart_Format = 1 " show small meny
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 0 " Do not close tags for other files
let Tlist_Enable_Fold_Column = 0 " Do not show folding tree
let g:ctags_path='D:/program/Vim/vim74/ctags.exe'
let g:ctags_statusline=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Minibuf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Matchit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" chenzw Test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"source $VIMRUNTIME/python.vim
filetype plugin on
"let g:pydiction_location = 'D:/program/Vim/vimfiles/ftplugin/complete-dict'
"let g:pydiction_menu_height = 15
set tags+=tags
set autochdir 

set fencs=utf-8,gbk
set fileencodings=utf-8,gb18030,utf-16,big5,gbk

"set encoding=utf-8 " 设置vim内部使用的字符编码,原来是cp936  
"lang messages zh_CN.UTF-8 " 解决consle输出乱码   

"set tags=d:\program\python27\lib\tags
set omnifunc=jedicomplete
let g:jedi#completions_command = "<C-N>"
 

