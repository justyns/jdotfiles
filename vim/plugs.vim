"-*- coding: utf-8 -*-
"
" from https://github.com/junegunn/vim-plug/wiki/faq
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

if has('win32')
    call plug#begin('~/.vim/plugged.win')
else
    call plug#begin('~/.vim/plugged')
endif

" From https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" vim-plug itself (adds help files/etc)
Plug 'junegunn/vim-plug'

" Theme
" Plug 'altercation/vim-colors-solarized'
" Plug 'sickill/vim-monokai'
Plug 'liuchengxu/space-vim-dark'
Plug 'vim-airline/vim-airline'

" https://github.com/tpope/vim-sensible
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dispatch' " Could potentially use skywind3000/asyncrun.vim instead for Vim8 async jobs

" searching / grep - only loaded when invoked
Plug 'mileszs/ack.vim', { 'on': ['Ack', 'Ag'] }

" navigation
Plug 'ctrlpvim/ctrlp.vim'  " , { 'on': ['CtrlP', 'CtrlPBuffer', 'CtrlPMixed'] }
" netrw has some bugs when using it as a "sidebar", so just use NerdTree for
" now if I need it.  Load on demand.
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'ryanoasis/vim-devicons'  " TODO: Figure out how to load this only if I have the right font
" if v:version >= 704
"     Plug 'terryma/vim-multiple-cursors'
" endif

" Syntax hilighting for various things
Plug 'ekalinin/Dockerfile.vim'   " , { 'for': 'dockerfile' }
Plug 'dag/vim-fish'
" Plug 'rodjek/vim-puppet'
Plug 'hdima/python-syntax'
Plug 'saltstack/salt-vim'
Plug 'markcornick/vim-vagrant'
Plug 'tpope/vim-markdown'
" Plug 'othree/javascript-libraries-syntax.vim'
Plug 'vadv/vim-chef'
Plug 'hashivim/vim-terraform'
" Plug 'juliosueiras/vim-terraform-completion'
" Plug 'hashivim/vim-nomadproject'
" Plug 'fatih/vim-hclfmt'
" Plug 'b4b4r07/vim-hcl'
Plug 'martinda/Jenkinsfile-vim-syntax'
if !(v:version < 704 || (v:version == 704 && !has('patch1689')))
    Plug 'fatih/vim-go'
endif

" Python
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Text-based accounting
" Plug 'ledger/vim-ledger'
" Plug 'nathangrigg/vim-beancount'

" misc plugins
Plug 'stephpy/vim-yaml'   " faster yaml processing for salt files with large lines
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'editorconfig/editorconfig-vim'    " https://editorconfig.org/
Plug 'Yggdroot/indentLine'
Plug 'mbbill/undotree'

if v:version >= 800
    Plug 'ludovicchabant/vim-gutentags'
endif

" syntax checker / linter
if v:version >= 800
    Plug 'w0rp/ale'    " async linter for vim 8+
else
    Plug 'scrooloose/syntastic'   " and use syntastic on older versions
endif

" Code completion via YCM.  It's kind of a big install, but it usually works
" pretty well compared to the other ones I've tried.
" For now, I'm also excluding windows because compiling YCM on windows is a
" bit more work.
" if !(v:version < 704 || (v:version == 704 && !has('patch1578'))) || !has('win32')
"     Plug 'Valloric/YouCompleteMe', { 'do': './install.py --go-completer' }
" endif

" Try ncm for now..  pynvim is also needed (pip3 install pynvim)
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-markdown-subscope'

" Trying out COC instead of YCM for a while
" https://github.com/neoclide/coc.nvim
if v:version >= 801
    " TODO: This requires yarn/npm/javascript..  Figure out how to detect if
    "       I have it and use something else if not
    " Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
    " TODO: Disabling for now..  It doesn't seem to be any better than YCM,
    "       and has more requirements
    " TODO: Try deoplete instead?  Or neovim+ncm2
endif
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'ncm2/ncm2'
" 
" " enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()
" 
" " IMPORTANT: :help Ncm2PopupOpen for more information
" set completeopt=noinsert,menuone,noselect
" 
" " NOTE: you need to install completion sources to get completions. Check
" " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'

Plug 'ajh17/VimCompletesMe'
Plug 'juliosueiras/vim-terraform-completion'

" Snippets
Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

call plug#end()
