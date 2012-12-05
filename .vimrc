

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use VIM settings, no vi compatibility
set nocompatible

filetype off                   " required for Vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Github scripts
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-rails'
Bundle 'vim-scripts/localvimrc'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-abolish'
Bundle 'tsaleh/vim-supertab'
Bundle 'garbas/vim-snipmate'
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'altercation/vim-colors-solarized'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'sjl/gundo.vim'
Bundle 'tomasr/molokai'
Bundle 'kevinw/pyflakes-vim'
Bundle 'pyflakes/pyflakes'
Bundle 'TagHighlight'
" Vim.org scripts
Bundle 'taglist.vim'
Bundle 'bufexplorer.zip'
Bundle 'vimlatex'
" Non - GitHib Repos

" Colour scheme
syntax enable
set background=dark
set t_Co=256
colorscheme molokai 
let g:molokai_original = 1

" Fix some of the molokai colours

autocmd ColorScheme * highlight MatchParen cterm=bold ctermbg=none ctermfg=green

syn keyword std boost

" ======================================================================================= Plugin options

" Clang_complete options
let g:clang_complete_copen=0

" Local vimrc
let g:localvimrc_count   = 1
let g:localvimrc_sandbox = 0
let g:localvimrc_ask     = 0

" Control-p is bad at managing working-dir, so disable it
let g:ctrlp_working_path_mode = 0
" Remove respo directories from search
let g:ctrlp_custom_ignore = '\.git\|\.hg\|\.svn\|build\|\.un\~$\|\.a\|\.d\|\.o\|\.java$'

" Taglist stuff
let Tlist_Close_On_Select=1
let Tlist_Auto_Highlight_Tag=1
let Tlist_Use_Right_Window=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_WinWidth=150
let Tlist_Sort_Type="name"

" Gundo
let g:gundo_width=100
let g:gundo_preview_bottom=1


" ====================================================================================== Auto Command

if has("autocmd")
  filetype plugin on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  augroup prog
  au!

  " Don't expand tabs to spaces in Makefiles
  au BufEnter  [Mm]akefile*  set noet
  au BufLeave  [Mm]akefile*  set et

  " relative numbers make .tex editing laggy
  au BufEnter *.tex set norelativenumber | set number
  au BufLeave *.tex set relativenumber

  augroup END

endif " has("autocmd")

" New leader
let mapleader=','

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set relativenumber
" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Searching
set ignorecase
set smartcase " Case-sens. search if the string contains a capital
set gdefault
set incsearch
set showmatch
set switchbuf=newtab " Open GCC errors in new tab

" Handle long lines
set wrap
set formatoptions=qrn1

" Directories
set backupdir=~/.vimback,/tmp

set directory=.,~/.vimback,/tmp
let yankring_history_dir="~/.vim"

" Just stuff that makes things better ;)
set nocp
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:full
"set visualbell
set nocursorline "cursor line is annoying
set ttyfast
set ruler
set laststatus=2
set undofile

" ============================================================================================= Mappings

" Move text, but keep highlight
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" Allow the . to execute once for each line in visual selection
vnoremap . :normal .<CR>

" Make j/k behave as expected for multi-row lines
nnoremap j gj
nnoremap k gk

" Open a new tab
nnoremap <leader>t :tabnew<cr>

nnoremap <silent> <leader>l :TlistToggle<cr>

"   F4 = kill buffer without losing splits
nmap     <F4> <Plug>BufKillBd

" Buffer explorer
nnoremap <leader>e :BufExplorer<cr>
nnoremap <leader>bb :bp<cr>
nnoremap <leader>bf :bn<cr>

" gundo shortcut
nnoremap <F5> :GundoToggle<CR>

" Fix some Vim awkwardness 
nnoremap Y y$
command Wa wa
command Wqa wqa
" Make escaping easier
inoremap jj <ESC>
" I like ctrl-s to save-all
nnoremap <leader>s :wa

" Writing : is annoying
nnoremap <leader>; :

" ^ is annoying
nnoremap <leader>1 ^

" Moving around splits
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Removal of highlight & tab to goto matching brace
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
" ================================================================ F-key shortcuts

" I keep hitting F1 when I mean ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" ===================================================================== Tabularize mapping

"nnoremap <leader>a :Tabularize /\S\zs .*\(;\\|\/\{2}\\|\/\*\)<cr>:Tabularize /=.*\(;\\|\/\{2}\\|\/\*\)<cr>:Tabularize /;.*\zs\/\{2}<cr>
"vnoremap <leader>a :Tabularize /\S\zs .*\(;\\|\/\{2}\\|\/\*\)<cr>:Tabularize /=.*\(;\\|\/\{2}\\|\/\*\)<cr>:Tabularize /;.*\zs\/\{2}<cr>
"nnoremap <leader>f :Tabularize /\S\zs .*\ze(<cr>:Tabularize /(<cr>
"vnoremap <leader>f :Tabularize /\S\zs .*\ze(<cr>:Tabularize /(<cr>

" Improved = alignment:
nnoremap <leader>z  :Tabularize /
nnoremap <leader>aa :Tabularize / \<\w\{1,\} =<cr> :Tabularize /=<cr>
vnoremap <leader>aa :Tabularize / \<\w\{1,\} =<cr> :Tabularize /=<cr>

nnoremap <leader>ag :Tabularize / [sg]et/l0<cr> :Tabularize /[sg]et\w*\zs(<cr> :Tabularize /[sg]et.*\zs)<cr> :Tabularize /{<cr> :Tabularize /=<cr> :Tabularize /}<cr>
vnoremap <leader>ag :Tabularize / [sg]et/l0<cr> :Tabularize /[sg]et\w*\zs(<cr> :Tabularize /[sg]et.*\zs)<cr> :Tabularize /{<cr> :Tabularize /=<cr> :Tabularize /}<cr>

nnoremap <leader>ai :Tabularize /_.*\zs(<cr> :Tabularize /^ .*\zs)<cr>

" Easier saving
nnoremap <leader>s :wa<cr>

" Switch between code and header file
nnoremap <leader>o  :FSHere<cr>
nnoremap <leader>io :FSSplitLeft<cr>
nnoremap <leader>po :FSSplitRight<cr>

" ====================================================================== General, uninteresting stuff

" Priorities for file name completion
set suffixes-=.h        " Don't give .h low priority
set suffixes+=.aux
set suffixes+=.log
set suffixes+=.bak
set suffixes+=~
set suffixes+=.swp
set suffixes+=.o
set suffixes+=.class

" Disable bracket errors (fucks up in C++0x atm)
:hi link cErrInParen Normal
:hi link cErrInBracket Normal

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Some security vulns exist with using modelines
set modelines=0

"if has("autocmd")
"    autocmd bufwritepost .vimrc source $MYVIMRC
"endif
