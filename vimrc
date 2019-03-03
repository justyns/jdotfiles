" Needed so fish doesn't break vim - https://github.com/dag/vim-fish
if &shell =~# 'fish$'
    set shell=sh
endif

" Needed because of this bug: https://github.com/vim/vim/issues/3117
" Can probably be removed later
if has('python3')
  silent! python3 1
endif

" runtime bundle/vim-pathogen/autoload/pathogen.vim
" call pathogen#infect()
" vim-plug https://github.com/junegunn/vim-plug
so ~/.vim/plugs.vim

syntax on
" colorscheme desert
" colorscheme solarized
" colorscheme monokai
set background=dark
colorscheme space-vim-dark

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

" Tabs
set expandtab       " Turn tabs into spaces
set tabstop=4       " number of visual spaces per tab
set shiftwidth=4
set softtabstop=4   " number of spaces in a tab when editing

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

" pressing ,<space> clears the search highlights
nmap <silent> <leader><space> :nohlsearch<CR>

" for when you mess up and hold shift too long
command W w
command WQ wq
command Wq wq
command Q q

" run a shell command and put the output in a scratch buffer
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" save undo/swap/backup files in a central location instead of cluttering up
" the current directory.  Unless the tmp dirs aren't writable, then it still
" goes to the current directory.
set backupdir=$HOME/.vim/tmp//,$HOME/tmp//,.
set directory=$HOME/.vim/tmp//,$HOME/tmp//,.
set undodir=$HOME/.vim/tmp//,$HOME/tmp//,.

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

" Tagbar
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR><C-w><C-w>

" ctrlp for tags
nnoremap <leader>. :CtrlPTag<CR>

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
" set colorcolumn=85

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

" Toggle paste mode with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>


" Open ~/.vimrc in a split window
" ,ev - edit vimrc
" ,sv - reload vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>


" Use <leader>a and n to switch between buffers (similar to my tmux/screen
" config)
map <Leader>a :bprev<Return>
map <Leader>p :bprev<Return>
map <Leader>n :bnext<Return>
map <Leader>d :bd<Return>
map <Leader>D :bw<Return>
map <Leader>f :b
nmap <Leader>bb :ls<CR>:buffer<Space>

" Use <leader>t to toggle nerdtree
map <Leader>t :NERDTreeToggle<Return>

" Format javascript
nmap =j :%!python -m json.tool<CR>

" Format python using yapf (from
" https://github.com/mindriot101/vim-yapf#why-you-may-not-need-this-plugin)
nmap =y :%!yapf<CR>


" From http://www.vimbits.com/bits/153 - TODO: Move to its own file
" Motions to Ack for things. Works with pretty much everything, including: w,
" W, e, E, b, B, t*, f*, i*, a*, and custom text objects.
"
" For example: \aiw will Ack for the word under the cursor. \aib will Ack for
" the contents of the parentheses the cursor is inside.
nnoremap <silent> \a :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> \a :<C-U>call <SID>AckMotion(visualmode())<CR>

function! s:CopyMotionForType(type)
    if a:type ==# 'v'
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent execute "normal! `[v`]y"
    endif
endfunction

function! s:AckMotion(type) abort
    let reg_save = @@

    call s:CopyMotionForType(a:type)

    execute "normal! :Ack! --literal " . shellescape(@@) . "\<cr>"

    let @@ = reg_save
endfunction


" Folding stuff
set foldmethod=syntax
set foldnestmax=2
set nofoldenable
nnoremap <Space> za   " Toggle current fold open/closed

" Flake8 stuff
let g:flake8_show_in_gutter=1

" https://github.com/othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'jquery,angularjs,react'

" Set default font for MacVim
if has('win32')
    set guifont=Consolas:h12   " Win32.
elseif has('gui_macvim')
    " set guifont=Monaco:h14     " OSX.
    " downloaded from https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts
    " see also: https://app.programmingfonts.org/#input
    set guifont=HackNerdFontComplete-Regular:h14
    " set guifont="SauceCodeProNerdFontCompleteM-Regular:h14"
else
    set guifont=Monospace\ 12  " Linux.
endif

set wildignore=*.swp,*.bak,*.pyc,*.class,tags
set title  " Change the title in the terminal


" From http://nvie.com/posts/how-i-boosted-my-vim/ - use w!! to write
" something as root
cmap w!! w !sudo tee % >/dev/null

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'     " Persist ctrlp cache to disk

" Check if ag (the_silver_searcher) is installed
if executable('ag')
    " If ag is installed, use it for ctrlp instead of the built in search
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " Also use it for ack.vim due to https://github.com/rking/ag.vim/issues/124#issuecomment-227038003
    let g:ackprg = 'ag --vimgrep --smart-case'
    cnoreabbrev ag Ack
    cnoreabbrev Ag Ack
endif

" For chef berkshelf
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Berksfile set filetype=ruby

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = [ 'rubocop' ]

" Hide Info window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" For ledger
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
let g:ledger_maxwidth = 120
let g:ledger_fold_blanks = 1
function LedgerSort()
    :%! ledger -f - print --sort 'date, amount'
    :%LedgerAlign
endfunction
command LedgerSort call LedgerSort()

" Ultisnips
let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsListSnippets="<c-k>" "List possible snippets based on current file

" https://github.com/SirVer/ultisnips/issues/376 - get YCM and Ultisnips to work together
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

" YouCompleteMe YCM
let g:ycm_key_list_select_completion=["<tab>"]
let g:ycm_key_list_previous_completion=["<S-tab>"]
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" EditorConfig - https://github.com/editorconfig/editorconfig-vim#readme
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" ! | l 1 Z 2 0 O o @ ao g bd m n () [] {} <> ; : '' "" ? -_+=^ 
