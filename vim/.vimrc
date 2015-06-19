
set nocompatible | filetype indent plugin on | syn on

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  set runtimepath+=/home/chris/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('/home/chris/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'


NeoBundle 'Shougo/vimproc.vim', { 'build' : { 'linux' : 'make', }, }
NeoBundle 'vim-scripts/localvimrc'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'ervandew/supertab'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'derekwyatt/vim-fswitch'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'brookhong/cscope.vim'
NeoBundle 'nelson/cscope_maps'
NeoBundle 'Valloric/YouCompleteMe', { 'build' : { 'linux' : './install.sh --clang-completer', }, }
NeoBundle 'SirVer/ultisnips'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'majutsushi/tagbar'
" Colors
NeoBundle 'bbchung/clighter'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'octol/vim-cpp-enhanced-highlight'

" Bundle 'tomtom/tlib_vim'
" Bundle 'Shougo/unite-outline'
" Bundle 'kien/ctrlp.vim'
" Bundle 'TagHighlight'
" Bundle 'vim-scripts/LanguageTool'
" Bundle 'scrooloose/syntastic'
" Bundle 'bling/vim-airline'
" Bundle 'justinmk/vim-sneak'
" Bundle 'rking/ag.vim'
" Bundle 'wellle/targets.vim'
" Bundle 'terryma/vim-smooth-scroll'
" Bundle 'derekwyatt/vim-scala'
" " Bundle 'jeaye/color_coded'
" Bundle 'altercation/vim-colors-solarized'
" Bundle 'zeis/vim-kolor'
" Bundle 'tomasr/molokai'
" Bundle 'sjl/badwolf'
" Bundle 'vimlatex'
" Bundle 'mayansmoke'
" 
"  Requires lua instead of luajit
" NeoBundleLazy 'jeaye/color_coded', { 'build': { 'unix': 'cmake . && make && make install', }, 'autoload' : { 'filetypes' : ['c', 'cpp', 'objc', 'objcpp'] }, 'build_commands' : ['cmake', 'make'] }
"

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" New leader
let mapleader=','

"
" Colors {{{
"

syntax enable

colorscheme lucius
LuciusDark

syn keyword std boost

" Enable doxygen highlight
let g:load_doxygen_syntax=1

let g:clighter_autostart = 1 
let g:clighter_libclang_file = '/home/chris/.vim/bundle/YouCompleteMe/third_party/ycmd/libclang.so'
let g:clighter_occurrences_mode = 0

hi clighterNamespaceRef term=NONE cterm=NONE ctermbg=NONE ctermfg=50 gui=NONE
hi clighterDeclRefExprCall term=NONE cterm=NONE ctermbg=NONE ctermfg=151 gui=NONE
hi clighterMemberRefExprCall term=NONE cterm=NONE ctermbg=NONE ctermfg=151 gui=NONE
hi clighterMemberRefExprVar term=NONE cterm=NONE ctermbg=NONE ctermfg=51 gui=NONE
hi clighterTypeRef term=NONE cterm=NONE ctermbg=NONE ctermfg=155 gui=NONE
hi clighterRef term=NONE cterm=NONE ctermbg=NONE ctermfg=51 gui=NONE

"
" }}}
" Folding {{{

set foldmethod=marker 

" 
"}}} 
" Plugin options                                    {{{
" 

" airline {{{
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#whitespace#checks = [ ]

" }}} 
" Syntastic {{{
let g:syntastic_always_populate_loc_list = 1

let g:languagetool_jar='$HOME/.vim/LanguageTool/LanguageTool.jar'

" }}} 
" Local vimrc 
let g:localvimrc_count   = 1
let g:localvimrc_sandbox = 0
let g:localvimrc_ask     = 0

" }}}
" Unite {{{

let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 1
nnoremap <C-p>     :Unite -no-split -buffer-name=files -immediately file_rec/async:!<cr>
nnoremap <space>/  :Unite ag:.<cr>
nnoremap <C-n>     :Unite -no-split -here -buffer-name=yank history/yank<cr>
nnoremap <space>s  :Unite -quick-match buffer -immediately<cr>
nnoremap <leader>o :Unite -no-split -buffer-name=outline -winheight=60 -profile-name=outline -immediately -auto-preview outline<cr>

call unite#custom#profile( 'outline', 'filters', ['sorter_rank'] )

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Use the rank sorter for everything
"call unite#filters#sorter_default#use(['sorter_rank'])

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.hg/',
      \ '\.svn/',
      \ '\.cov_html/',
      \ 'build/',
      \ 'plotData/',
      \ 'results/',
      \ '\.un\~$',
      \ '\.a',
      \ '\.d',
      \ '\.o',
      \ '\.class',
      \ ], '\|'))

" }}}
" sneak {{{
nmap f <Plug>SneakForward
nmap F <Plug>SneakBackward
xmap f <Plug>VSneakForward
xmap F <Plug>VSneakBackward

" }}} 
" tagbar {{{
nnoremap <leader>p :let g:tagbar_width=150<cr>:TagbarOpen fjc<cr>
nnoremap <leader>P :let g:tagbar_width=50<cr>:TagbarOpen j<cr>

" }}}
" Gundo {{{
let g:gundo_width=100
let g:gundo_preview_bottom=1

nnoremap <F5> :GundoToggle<CR>
nnoremap <F4> :set invpaste<CR>i
inoremap <F4> <ESC>:set invpaste<CR>i

" }}}
" YouCompleteMe {{{
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_collect_identifiers_from_tags_files=1
" Prevent warning about .ycm_extra_config.py for my projects
let g:ycm_extra_conf_globlist = ['~/nids/*','~/coding/*', '~/dev/*']

nnoremap <C-w> :YcmCompleter GoTo<cr>
nnoremap <C-e> :YcmCompleter GoToImprecise<cr>
nnoremap <leader>f :YcmDiags<cr>

" }}}
" ultisnip  {{{

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
"
" " better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}
" vim-easy-align {{{

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <leader>z <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>z <Plug>(EasyAlign)
" }}}
" 
" Fswitch {{{
nnoremap <O  :FSHere<cr>
nnoremap <IO :FSSplitLeft<cr>
nnoremap <PO :FSSplitRight<cr>
" }}}

"
" }}}
"

" ====================================================================================== Auto Command

if has("autocmd")
  filetype plugin on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

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

  " Enable spellcheck for tex and text files 
  au BufEnter *.tex setlocal spell spelllang=en_us 
  au FileType text setlocal spell spelllang=en_us 

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

" Scrolling 
set scrolloff=10
set scrolljump=3

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

" Make background work properly with screen/tmux
set t_ut=
set timeout timeoutlen=200 ttimeoutlen=1
set nocp
set encoding=utf-8
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
 
" <Leader>0: Run the visually selected code in python and replace it with the " " output
vnoremap <silent> <Leader>0 :!python<cr>

"
" Update tag/csope databases
function UpdateTags() 
"    silent call TagHighlight#Generation#UpdateAndRead(0)
    silent call system( "ctags-exuberant -R * && find . -name '*.cc' -or -name '*.h' > cscope.files && cscope -b -q -i cscope.files" )
endfunction

command UpdateTags :call UpdateTags()<cr>

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

" Fix some Vim awkwardness 
nnoremap Y y$
command Wa wa
command Wqa wqa
" Make escaping easier
inoremap jj <ESC>

nnoremap <leader>s :wa<cr>

" Writing : is annoying
nnoremap <leader>; :

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
