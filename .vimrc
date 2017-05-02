" ------------------------------------------------------------------------------
" Credits:
" Most of the content of this files was taken from
" https://github.com/Valloric/dotfiles/blob/master/vim/vimrc.vim
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Preamble
" ------------------------------------------------------------------------------

set nocompatible

set langmenu=en_US.UTF-8    " Sets the language of the menu (gvim)
language messages en        " Sets the language of the messages / ui (vim)

" Move viminfo
set viminfo+=n$HOME/vimfiles/.viminfo

" ------------------------------------------------------------------------------
" Vundle configuration
" ------------------------------------------------------------------------------

" Required by Vundle, turned on after Vundle configuration is completed
filetype off

set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
call vundle#begin('$HOME/vimfiles/bundle/')

" Let Vundle manage Vundle
Plugin 'vundlevim/vundle.vim'

" My bundles here:
Plugin 'google/vim-maktaba'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'PProvost/vim-ps1'
Plugin 'dantler/vim-alternate'
Plugin 'kien/ctrlp.vim'
Plugin 'endel/vim-github-colorscheme'
Plugin 'rking/ag.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'drmikehenry/vim-fontsize'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'mhinz/vim-startify'

call vundle#end()

" Required by vim-codefmt
call glaive#Install()

" ------------------------------------------------------------------------------
" Reset vimrc augroup
" ------------------------------------------------------------------------------

" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
  autocmd!
augroup END

" ------------------------------------------------------------------------------
" Turn on file specific plugins. Must be done after Vundle is configured
" ------------------------------------------------------------------------------

filetype plugin indent on

" ------------------------------------------------------------------------------
" General settings
" ------------------------------------------------------------------------------

" Display setings
" ---------------
set lines=40 columns=100

set background=light
colorscheme PaperColor

set scrolloff=2         " 2 lines above/below cursor when scrolling
set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set go=                 " hide all ui elements
set colorcolumn=81      " show a column som we can track the line length at 80
set number              " show line numbers

set guifont=Source_Code_Pro:h10

" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu

" The "longest" option makes completion insert the longest prefix of all
" the possible matches; see :h completeopt
set completeopt=menu,menuone,longest
set completeopt-=preview
set switchbuf=useopen,usetab

" Editor settings
" ----------------

set encoding=utf-8      " ignore platform specific encodings
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set autoindent          " on new lines, match indent of previous line
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=:0,l1,g0,N-s,t0,(0,W4  " see :h cinoptions-values
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set nobackup            " no backup~ files.

set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
set shiftround          " makes indenting a multiple of shiftwidth
set expandtab           " turn a tab into spaces
set laststatus=2        " the statusline is now always shown
set noshowmode          " don't show the mode ("-- INSERT --") at the bottom

set history=1000        " remember more commands and search history
set undolevels=1000     " use many levels of undo
set autoread            " auto read when a file is changed from the outside
set mouse=a             " enables the mouse in all modes
set foldlevelstart=99   " all folds open by default

" Right-click on selection should bring up a menu
set mousemodel=popup_setpos

" tries to avoid those annoying "hit enter to continue" messages
" if it still doesn't help with certain commands, add a second <cr>
" at the end of the map command
set shortmess=a

" this solves the "unable to open swap file" errors on Win7
set dir=~/tmp,/var/tmp,/tmp,$TEMP
set undodir=~/tmp,/var/tmp,/tmp,$TEMP

" turns off all error bells, visual or otherwise
set noerrorbells visualbell t_vb=
autocmd vimrc GUIEnter * set visualbell t_vb=

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" allow backspace and cursor keys to cross line boundaries
set whichwrap+=<,>,h,l
set nohlsearch          " do not highlight searched-for phrases
set incsearch           " ...but do highlight-as-I-type the search string
set gdefault            " this makes search/replace global by default

" enforces a specified line-length and auto inserts hard line breaks when we
" reach the limit; in Normal mode, you can reformat the current paragraph with
" gqap.
set textwidth=80

" options for formatting text; see :h formatoptions
set formatoptions=tcroqnj

if has('unnamedplus')
  " By default, Vim will not use the system clipboard when yanking/pasting to
  " the default register. This option makes Vim use the system default
  " clipboard.
  " Note that on X11, there are _two_ system clipboards: the "standard" one, and
  " the selection/mouse-middle-click one. Vim sees the standard one as register
  " '+' (and this option makes Vim use it by default) and the selection one as
  " '*'.
  " See :h 'clipboard' for details.
  set clipboard=unnamedplus,unnamed
else
  " Vim now also uses the selection system clipboard for default yank/paste.
  set clipboard+=unnamed
endif

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
autocmd vimrc FileType text,markdown,gitcommit set nocindent

" ------------------------------------------------------------------------------
" Custom mappings
" ------------------------------------------------------------------------------

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" ------------------------------------------------------------------------------
"                                 PLUGINS
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Airline
" ------------------------------------------------------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------

let NERDTreeDirArrows=1
let NERDTreeBookmarsFile = '$HOME/vimfiles/.NERDTreeBookmarks'

" ------------------------------------------------------------------------------
" CtrlP
" ------------------------------------------------------------------------------

let g:ctrlp_by_filename = 0
let g:ctrlp_cache_dir = '$HOME/vimfiles/ctrlp/'

" Skip AS specific files
set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*

" ------------------------------------------------------------------------------
" codefmt
" ------------------------------------------------------------------------------

Glaive codefmt plugin[mappings]
