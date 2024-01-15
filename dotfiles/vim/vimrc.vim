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

" remap next/prev char search from ;/, to make space
nmap <C-p> ,
nmap <C-n> ;
" beautifully saves two keystrokes entering command mode
nnoremap ; :
vnoremap ; :
" I'm always hitting escape. My life is changed now: let's not leave the home row.
inoremap jf <esc>
vnoremap jf <esc>
cnoremap jf <esc>
" see near highlighting below that , also gets repurposed

" forgot sudo? use this (once I understand it):
" cmap w!! w !sudo tee % >/dev/null

" make 0 work like ^ when not at the start of the text on a line, otherwise keep its default functionality. so if I want to go to the actual start of the line, I press 0 twice:
nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
vnoremap <expr> <silent> <home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
" FIXME for some reason, I can't get the home key to actually register as a
" thing in insert mode
"inoremap <expr> <silent> <home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

" make a new paragraph
nnoremap oo o<esc>O

" I don't use `s`, but it's easier to hit then `v`
" therefore, the `s` key now changes into "select" mode, which I always want
" to be visual
nnoremap s v
" and while I'm at it, let's make it a toggle
vnoremap s <esc>
" and I'll also use `a` for "alter" a synonym for "change" that's harder to
" typo
vnoremap a c

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

set number
" make Nj and Nk easier; taking the compiler's advice is easy as Ngg
" set relativenumber
" OR, just scroll with mouse and only use Nj/Nk in macro recordings for short
" jumps
set mouse=a


" make whitespace visible
set list
set listchars=tab:├─,trail:·
set listchars+=precedes:…,extends:…

""" non-text keeb keys """

" good indentation settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab " use spaces instead of tabs.
set smarttab " lets tab key insert 'tab stops', and bksp deletes tabs.
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
