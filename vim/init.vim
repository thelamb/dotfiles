
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
NeoBundle 'Shougo/unite-outline'
NeoBundle 'derekwyatt/vim-fswitch'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'brookhong/cscope.vim'
NeoBundle 'nelson/cscope_maps'
NeoBundle 'Valloric/YouCompleteMe', { 'build' : { 'linux' : './install.sh --clang-completer', }, }
NeoBundle 'SirVer/ultisnips'
NeoBundle 'junegunn/vim-easy-align'
"NeoBundle 'kana/vim-smartinput'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'unblevable/quick-scope'
NeoBundle 'wellle/targets.vim'

" Colors
"NeoBundle 'bbchung/clighter'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'justinmk/molokai'
NeoBundle 'frankier/neovim-colors-solarized-truecolor-only'

"NeoBundle 'rking/ag.vim'
"NeoBundle 'majutsushi/tagbar'
" Bundle 'tomtom/tlib_vim'
" Bundle 'TagHighlight'
" Bundle 'vim-scripts/LanguageTool'
" Bundle 'bling/vim-airline'
" Bundle 'justinmk/vim-sneak'
" Bundle 'rking/ag.vim'
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

" filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" New leader
let mapleader=','

"
" Colors {{{
"

set termguicolors

"syntax enable

set background=dark
" colorscheme solarized

colorscheme lucius
LuciusDark

syn keyword std boost

" Enable doxygen highlight
let g:load_doxygen_syntax=1

let g:clighter_autostart = 1 
let g:clighter_libclang_file = '/home/chris/.vim/bundle/YouCompleteMe/third_party/ycmd/libclang.so'
let g:clighter_occurrences_mode = 0

:hi clighterNamespaceRef term=NONE cterm=NONE ctermbg=NONE ctermfg=50 gui=NONE
:hi clighterDeclRefExprCall term=NONE cterm=NONE ctermbg=NONE ctermfg=151 gui=NONE
:hi clighterMemberRefExprCall term=NONE cterm=NONE ctermbg=NONE ctermfg=151 gui=NONE
:hi clighterMemberRefExprVar term=NONE cterm=NONE ctermbg=NONE ctermfg=51 gui=NONE
:hi clighterTypeRef term=NONE cterm=NONE ctermbg=NONE ctermfg=155 gui=NONE
:hi clighterRef term=NONE cterm=NONE ctermbg=NONE ctermfg=51 gui=NONE

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
nnoremap <C-p>     :Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>e :Unite -no-split -start-insert buffer<cr>
nnoremap <leader>p :Unite -buffer-name=outline -vertical -profile-name=outline -start-insert outline<cr>
nnoremap <leader>y :Unite -no-split -buffer-name=yank history/yank<cr>
nnoremap <leader>/  :Unite -no-split -buffer-name=search grep:.<cr>

" Use rg for file_asyn
let g:unite_source_rec_async_command = [ 'rg', '--files' ]
let g:unite_source_rec_find_args = [ ]

" Use rg for 'search'
let g:unite_source_grep_command = 'rg'
let g:unite_source_grep_default_opts = '--follow --smart-case --line-number --no-heading --color=never '
let g:unite_source_grep_recursive_opt = ''

call unite#custom#profile( 'outline', 'filters', ['sorter_rank'] )

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_length'])

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.hg/',
      \ '\.svn/',
      \ '\.cov_html/',
      \ 'result-files/',
      \ 'nids$',
      \ 'core$',
      \ 'build/',
      \ 'third-party/',
      \ 'results/',
      \ 'web-nids/',
      \ 'tut-nids/',
      \ '\.pcap$',
      \ '\.un\~$',
      \ '\.a$',
      \ '\.d$',
      \ '\.o$',
      \ '\.so$',
      \ '\.class$',
      \ ], '\|'))

" }}}
" sneak {{{
"nmap f <Plug>SneakForward
"nmap F <Plug>SneakBackward
"xmap f <Plug>VSneakForward
"xmap F <Plug>VSneakBackward

" }}} 
" tagbar {{{
"nnoremap <leader>p :let g:tagbar_width=150<cr>:TagbarOpen fjc<cr>
"nnoremap <leader>P :let g:tagbar_width=50<cr>:TagbarOpen j<cr>

" }}}
" incsearch {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" }}}
" quick-scope {{{
" Only show quick-scope highlights after f/F/t/T is pressed
function! Quick_scope_selective(movement)
    let needs_disabling = 0
    if !g:qs_enable
        QuickScopeToggle
        redraw
        let needs_disabling = 1
    endif

    let letter = nr2char(getchar())

    if needs_disabling
        QuickScopeToggle
    endif

    return a:movement . letter
endfunction

let g:qs_enable = 0

for i in  [ 'f', 'F', 't', 'T' ]
    execute 'noremap <expr> <silent>' . i . " Quick_scope_selective('". i . "')"
endfor
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
let g:UltiSnipsJumpForwardTrigger = "<C-l>"
let g:UltiSnipsJumpBackwardTrigger = "<C-h>"

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

  " Automatically uncrustify before save
  au BufWritePre *.cc :call Uncrustify('cpp')
  au BufWritePre *.h :call Uncrustify('cpp')

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
set nojoinspaces
 
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
    silent call system( "ctags-exuberant --fields=+l -R * && find . -name '*.cc' -or -name '*.h' > cscope.files && cscope -b -q -i cscope.files" )
endfunction

command UpdateTags :call UpdateTags()<cr>

function! BreakHere()
s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
    call histdel("/", -1)
endfunction

nnoremap K :call BreakHere()<CR>

"nnoremap K i<CR><Esc>k:s/\s*$//<CR>j^:noh<CR>
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

" Run compilation in separate tmux
nnoremap <leader>c :!./chrisRunCompile.sh ut<cr><cr>
nnoremap <leader>C :!./chrisRunCompile.sh nids<cr><cr>

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

" Restore cursor position, window position, and last search after running a
" " command.
function! Preserve(command)
    " Save the last search.
    let search = @/

    " Save the current cursor position.
    let cursor_position = getpos('.')

    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)

    " Execute the command.
    execute a:command

    " Restore the last search.
    let @/ = search

    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt

    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

let g:uncrustify_cfg_file_path = shellescape(fnamemodify('~/dev/nids/helper-files/uncrustify.cfg', ':p'))

function! Uncrustify(language)
    call Preserve(':silent %!~/build/uncrustify-0.63/src/uncrustify'
        \ . ' -q '
        \ . ' -l ' . a:language
        \ . ' -c ' . g:uncrustify_cfg_file_path)
endfunction
