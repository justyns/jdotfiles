"-*- coding: utf-8 -*-
"
" from https://github.com/junegunn/vim-plug/wiki/faq
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Theme
" Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
Plug 'bling/vim-airline'

" https://github.com/tpope/vim-sensible
Plug 'tpope/vim-sensible'

" searching / grep - only loaded when invoked
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'rking/ag.vim', { 'on': 'Ag' }

" navigation
Plug 'ctrlpvim/ctrlp.vim'  " , { 'on': ['CtrlP', 'CtrlPBuffer', 'CtrlPMixed'] }
" netrw has some bugs when using it as a "sidebar", so just use NerdTree for
" now if I need it.  Load on demand.
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'

" Syntax hilighting for various things
Plug 'ekalinin/Dockerfile.vim'   " , { 'for': 'dockerfile' }
Plug 'dag/vim-fish'
Plug 'rodjek/vim-puppet'
Plug 'hdima/python-syntax'
Plug 'saltstack/salt-vim'
Plug 'markcornick/vim-vagrant'
Plug 'tpope/vim-markdown'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'vadv/vim-chef'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-nomadproject'
if !(v:version < 704 || (v:version == 704 && !has('patch1689')))
    Plug 'fatih/vim-go'
endif

" Python
" Plug 'davidhalter/jedi-vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Text-based accounting
Plug 'ledger/vim-ledger'
Plug 'nathangrigg/vim-beancount'

" misc plugins
Plug 'stephpy/vim-yaml'   " faster yaml processing for salt files with large lines
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
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
if !(v:version < 704 || (v:version == 704 && !has('patch1578')))
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
endif
Plug 'juliosueiras/vim-terraform-completion'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


call plug#end()
