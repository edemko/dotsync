set nocompatible

execute pathogen#infect()

set hidden
set lazyredraw
set showmode

set timeout timeoutlen=200 " fixes that `O` takes a long time sometimes (i.e. after hitting ESC)
" be aware: this also changes how quickly you need to hit `ys` in vim-surround

syntax on
filetype plugin indent on


""" keybindings """

" remap next/prev char serach from ;/, to make space
nmap <C-p> ,
nmap <C-n> ;
" beautifully saves two keystrokes entering command mode
nnoremap ; :
vnoremap ; :
" I'm always hitting escape. My life is changed now: let's not leave the home row.
inoremap jf <esc>
" see near highlighting below that , also gets repurposed

" forgot sudo? use this (once I understand it):
" cmap w!! w !sudo tee % >/dev/null


""" History """

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo


""" viewing """

set nowrap
set showmatch " highlight matching paren
set hlsearch
" clear the search register to eliminate over-highlighting
nmap <silent> , :nohlsearch<CR>
set gdefault

" make Nj and Nk easier; taking the compiler's advice is easy as Ngg
set relativenumber

" make whitespace visible
set list
set listchars=tab:├─,trail:·
set listchars+=precedes:…,extends:…

""" non-text keeb keys """

" good indentation settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent
set copyindent

" indent to backspace over indentation, eol to go over end of line, start to go past where the insert started
set backspace=indent,eol,start

" press F2 before pasting text from outside to avoide cascading indents
set pastetoggle=<F2>




" much better tab-autocomplete than pure cycling
set wildmenu
set wildmode=longest:full,full
set wildignore=*.swp,*.bak
set wildignore+=*.pyc

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" status line
set laststatus=2 " always show status line
let g:airline_powerline_fonts = 1

" all the pretty colors
set background=dark
colorscheme delek

""" plugin settings """

let g:hexmode_patterns = '*.bin'
