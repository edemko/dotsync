execute pathogen#infect()

set timeout timeoutlen=100 " fixes that `O` takes a long time sometimes (i.e. after hitting ESC)

syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent

set relativenumber

set background=dark
colorscheme delek
