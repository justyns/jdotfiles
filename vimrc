" Needed so fish doesn't break vim - https://github.com/dag/vim-fish
if &shell =~# 'fish$'
    set shell=sh
endif

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
set background=dark
colorscheme desert
syntax on
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

" Tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Some settings from http://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader
set encoding=utf-8
set wildmenu
set wildmode=full



" Some stuff from http://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim
" Scroll 2 lines above/below cursor
set scrolloff=2
set showmode            " Show mode in status bar
set ruler               " show cursor position in status bar
set laststatus=2        " use 2 lines for the status bar
set matchtime=2         " show matching bracket for 0.2 seconds
set matchpairs+=<:>     " specially for html
set esckeys             " map missed escape sequences (enables keypad keys)
set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo

" Some stuff from http://www.terminally-incoherent.com/blog/2012/03/26/how-to-configure-vim/
" break compatibility with vi
set nocompatible

" enable inline spellcheck
" set spell
set spelllang=en

" show line and column markers
set cursorline
" set cursorcolumn

set autoindent
" copy previous indent on enter 
set copyindent
" set smartindent - disabling per comments in
" http://www.reddit.com/r/vim/comments/26z00g/going_to_start_learning_vim_pretty_overwhelmed/

set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
 
set incsearch       " incremental search
set hlsearch        " highlights searches

" Re-map the leader key from \ to ,
let mapleader = ","

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

" Turn on rainbow parantheses by default
" https://github.com/kien/rainbow_parentheses.vim
if exists('au')
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
endif

" Enable closetag for html/xml only
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" Tagbar
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" disable arrow keys to learn to use hjkl
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" Allowe hidden buffers
set hidden

" Fix backspace when using auto indent and stuff
set backspace=indent,eol,start

" Auto encrypt/decrypt files with .gpg extension.  From http://vim.wikia.com/wiki/Encryption
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
  au!
  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a various options which write unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup
  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null
  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END

" Statusline / airline settings
let g:airline#extensions#tabline#enabled = 1

" Easier split navigations -
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
" We can use different key mappings for easy navigation between splits to save
" a keystroke. So instead of ctrl-w then j, it’s just ctrl-j:
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Open new split panes to right and bottom, which feels more natural than
" Vim’s default
set splitbelow
set splitright

" Create vertical split using <leader>w and then switch to it
nnoremap <leader>w <C-w>v<C-w>l

" map jj to ESC to make it easier to leave insert mode
inoremap jj <ESC>

" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader
" Yank one line, paste it below, move to it and replace every character with =
" ie: Create MarkDown headings
nnoremap <leader>= yypVr=

" Use normal regex instead of vim's regex
nnoremap / /\v
vnoremap / /\v

" Use the tab key to move between brackets and paranthesis instead of %
nnoremap <tab> %
vnoremap <tab> %

" Add a color column at 85
set colorcolumn=85

"set wrap
"set textwidth=79
"set formatoptions=qrn1

" Re-map ; to : in normal-mode
nnoremap ; :

" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Use ack by pressing ,g
nnoremap <leader>g :Ack

" Select text that was just pasted
nnoremap <leader>v V`]

" Open ~/.vimrc in a split window
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>



" Use <leader>a and n to switch between buffers (similar to my tmux/screen
" config)
map <Leader>a :bprev<Return>
map <Leader>p :bprev<Return>
map <Leader>n :bnext<Return>
map <Leader>d :bd<Return>
map <Leader>f :b
nmap <Leader>bb :ls<CR>:buffer<Space>

