scriptencoding utf-8

call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
call plug#end()

syntax on
colorscheme onedark
let g:airline_theme='onedark'
let g:ctrlp_show_hidden=1
set expandtab
set cursorline
set autoindent
set backspace=indent,start,eol

if exists('$SUDO_USER')
  set nobackup
  set nowritebackup
else
  set backupdir=~/.vim/tmp/backup
  set backupdir+=.
endif

if has('linebreak') && has('mac')
  set breakindent
endif

if exists('$SUDO_USER')
  set noswapfile
else
  set directory=~/.vim/tmp/swap//
  set directory+=.
endif

if has('linebreak')
  set linebreak
endif

set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command
set noshowmatch                       " don't jump between matching brackets
set number                            " show line numbers in gutter

set scrolloff=3
