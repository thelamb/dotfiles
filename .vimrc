
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
Bundle 'brookhong/cscope.vim'
Bundle 'nelson/cscope_maps'
Bundle 'vim-scripts/localvimrc'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tsaleh/vim-supertab'
Bundle 'garbas/vim-snipmate'
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'sjl/gundo.vim'
Bundle 'TagHighlight'
Bundle 'vim-scripts/LanguageTool'
Bundle 'YankRing.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'bling/vim-airline'
Bundle 'justinmk/vim-sneak'
Bundle 'majutsushi/tagbar'
" Colors
Bundle 'altercation/vim-colors-solarized'
Bundle 'zeis/vim-kolor'
Bundle 'tomasr/molokai'
Bundle 'sjl/badwolf'
" Vim.org scripts
Bundle 'bufexplorer.zip'
Bundle 'vimlatex'
Bundle 'mayansmoke'
" Non - GitHib Repos

" New leader
let mapleader=','


" Colour scheme
syntax enable
set background=dark
set t_Co=256
"colorscheme mustang

colorscheme badwolf 
"colorscheme solarized
"colorscheme molokai 
let g:molokai_original = 1
"
"" Fix some of the molokai colours
"
autocmd ColorScheme * highlight MatchParen cterm=bold ctermbg=none ctermfg=green
autocmd ColorScheme * highlight def link doxygenComment SpecialComment
autocmd ColorScheme * highlight def link doxygenBrief Comment
autocmd ColorScheme * highlight def link doxygenSpecialOnelineDesc Comment

syn keyword std boost

" Enable doxygen highlight
let g:load_doxygen_syntax=1

" ======================================================================================= Plugin options

" airline
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#whitespace#checks = [ ]

" Syntastic
let g:syntastic_always_populate_loc_list = 1

let g:languagetool_jar='$HOME/.vim/LanguageTool/LanguageTool.jar'

" Local vimrc
let g:localvimrc_count   = 1
let g:localvimrc_sandbox = 0
let g:localvimrc_ask     = 0

" Control-p is bad at managing working-dir, so disable it
let g:ctrlp_working_path_mode = 0

" Remove respo directories from search
let g:ctrlp_custom_ignore = { 
 \ 'dir':  'plotData\|build\|.git\|.hg\|.svn',   
 \ 'file': '\.un\~$\|\.a\|\.d\|\.o\|\.class$',
 \ }

" sneak
nmap f <Plug>SneakForward
nmap F <Plug>SneakBackward
xmap f <Plug>VSneakForward
xmap F <Plug>VSneakBackward

" tagbar
nnoremap <leader>p :let g:tagbar_width=150<cr>:TagbarOpen fjc<cr>
nnoremap <leader>P :let g:tagbar_width=50<cr>:TagbarOpen j<cr>

" Gundo
let g:gundo_width=100
let g:gundo_preview_bottom=1

" YouCompleteMe

let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_collect_identifiers_from_tags_files=1
" Prevent warning about .ycm_extra_config.py for my projects
let g:ycm_extra_conf_globlist = ['~/nids/*','~/coding/*', '~/dev/*']

nnoremap <C-w> :YcmCompleter GoToDefinitionElseDeclaration<cr>
nnoremap <leader>f :YcmDiags<cr>
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

  " Enable spellcheck for tex files 
  au BufEnter *.tex setlocal spell spelllang=en_us 

  augroup END

endif " has("autocmd")

" Spellfile so that 'zg' and 'zw' store the good words
set spellfile="~/.vim/spellfile"

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set guioptions-=T  " remove toolbar
set guioptions-=r  " remove right hand scrollbar
set number         " Since vim 7.4, we can set both number and relativenumber at the same time
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
let g:yankring_replace_n_pkey='<C-n>' 
let g:yankring_replace_n_nkey='<C-m>'

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
set lazyredraw
"set visualbell
set nocursorline "cursor line is annoying
set ttyfast
set ruler
set laststatus=2
set undofile

let b:TypesFileRecurse = 1

" ============================================================================================= Mappings
"
" Update tag/csope databases
function UpdateTags() 
    silent call TagHighlight#Generation#UpdateAndRead(0)
    silent call system( "ctags-exuberant -R * && find . -name '*.cc' -or -name '*.h' > cscope.files && cscope -b -i cscope.files" )
endfunction

command UpdateTags :call UpdateTags()<cr>

"" clang_complete
"nnoremap <leader>f :call g:ClangUpdateQuickFix()<cr>:cwindow<cr>
nnoremap <Q :cwindow<cr>
nnoremap <P :pclose<cr>

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

" Buffer explorer
nnoremap <leader>e :BufExplorer<cr>
nnoremap <leader>bb :bp<cr>
nnoremap <leader>bf :bn<cr>

" gundo shortcut
nnoremap <F5> :GundoToggle<CR>
nnoremap <F4> :set invpaste<CR>i
inoremap <F4> <ESC>:set invpaste<CR>i

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
nnoremap <W <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Removal of highlight & tab to goto matching brace
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" highlight last inserted text
nmap gV `[v`]           

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
nnoremap <leader>zd :Tabularize /\/\/!<<cr>
nnoremap <leader>aa :Tabularize / \<\w\{1,\} =<cr> :Tabularize /=<cr>
vnoremap <leader>aa :Tabularize / \<\w\{1,\} =<cr> :Tabularize /=<cr>

nnoremap <leader>ag :Tabularize / [sg]et/l0<cr> :Tabularize /[sg]et\w*\zs(<cr> :Tabularize /[sg]et.*\zs)<cr> :Tabularize /{<cr> :Tabularize /=<cr> :Tabularize /}<cr>
vnoremap <leader>ag :Tabularize / [sg]et/l0<cr> :Tabularize /[sg]et\w*\zs(<cr> :Tabularize /[sg]et.*\zs)<cr> :Tabularize /{<cr> :Tabularize /=<cr> :Tabularize /}<cr>

nnoremap <leader>ai :Tabularize /_.*\zs(<cr> :Tabularize /^ .*\zs)<cr>

" Easier saving
nnoremap <leader>s :wa<cr>

" Switch between code and header file
nnoremap <O  :FSHere<cr>
nnoremap <IO :FSSplitLeft<cr>
nnoremap <PO :FSSplitRight<cr>

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
