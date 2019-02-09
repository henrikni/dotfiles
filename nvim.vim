set nocompatible

" Vundle configuration
" ------------------------------------------------------------------------------

" Required by Vundle, turned on after Vundle configuration is completed.
filetype off

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'VundleVim/vundle.vim'

" My bundles here:
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'dantler/vim-alternate'
Plugin 'kien/ctrlp.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mhinz/vim-startify'
Plugin 'sonph/onehalf', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on

" General settings
" ------------------------------------------------------------------------------

" Display settings

set scrolloff=2         " 2 lines above/below cursor when scrolling.
set showmatch           " Show matching bracket (briefly jump).
set showmode            " Show mode in status bar (insert/replace/...).
set showcmd             " Show typed command in status bar.
set ruler               " Show cursor position in status bar.
set title               " Show file in titlebar.
set colorcolumn=81      " Show a column som we can track the line length at 80.
set number              " Show line numbers

" Editor settings

set encoding=utf-8      " Ignore platform specific encodings.
set ignorecase          " Case insensitive searching.
set smartcase           " But become case sensitive if you type uppercase characters.
set autoindent          " On new lines, match indent of previous line.
set copyindent          " Copy the previous indentation on autoindenting.
set smarttab            " Smart tab handling for indenting.
set magic               " Change the way backslashes are used in search patterns.
set bs=indent,eol,start " Allow backspacing over everything in insert mode.
set nobackup            " No backup~ files.

set tabstop=4           " Number of spaces a tab counts for.
set shiftwidth=4        " Spaces for autoindents.
set shiftround          " makes indenting a multiple of shiftwidth.
set expandtab           " Turn a tab into spaces.

set history=1000        " Remember more commands and search history.
set undolevels=1000     " Use many levels of undo.
set autoread            " Auto read when a file is changed from the outside.
set foldlevelstart=99   " All folds open by default.

" C/C++ specific.
augroup csrc
  au!
  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp  set cindent
augroup END

" Set common C/C++ formatting options.
set cinoptions=:0,g0,(0,Ws,l1

" Use truecolors.
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

" Switch syntax highlighting on, when the terminal has colors.
if &t_Co > 2
  syntax on
endif

colorscheme onehalfdark

" Allow backspace and cursor keys to cross line boundaries.
set whichwrap+=<,>,h,l

" Enforces a specified line-length and auto inserts hard line breaks when we
" reach the limit; in Normal mode, you can reformat the current paragraph with
" gqap.
set textwidth=80

" Options for formatting text; see :h formatoptions.
set formatoptions=tcroqnj

" clang-format integration
" ------------------------------------------------------------------------------
map <C-K> :pyf ~/bin/clang-format.py<cr>
imap <C-K> <c-o>:pyf ~/bin/clang-format.py<cr>

" Plugins
" ------------------------------------------------------------------------------

" Airline
let g:airline_powerline_fonts=1
let g:airline_theme='onehalfdark'

" NERDTree
let NERDTreeDirArrows=1

" CtrlP
let g:ctrlp_by_filename = 0
