set background=dark
colorscheme desert
syntax on
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

" Some stuff from http://www.terminally-incoherent.com/blog/2012/03/26/how-to-configure-vim/
" break compatibility with vi
set nocompatible

" enable inline spellcheck
set spell
set spelllang=en

" show line and column markers
" set cursorline
" set cursorcolumn

set autoindent
" copy previous indent on enter 
set copyindent
set smartindent

set showcmd     " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
 
set incsearch       " incremental search
set hlsearch        " highlights searches

" pressing \<space> clears the search highlights
nmap <silent> <leader><space> :nohlsearch<CR>

" for when you mess up and hold shift too long
command W w
command WQ wq
command Wq wq
command Q q

" save more in undo history
set history=1000
set undolevels=1000


if v:version >= 730
    set undofile        " keep a persistent backup file
endif

" Load indentation rules according to the detected filetype. 
if has("autocmd")
    filetype indent on
endif

"http://irssi.org/documentation/tips
"Auto update changed date to todates date
autocmd BufWrite *.pl %s/changed     => '.*/\="changed     => '" . strftime("%c") . "',"/e
map <C-B> :w !php -l <CR>
