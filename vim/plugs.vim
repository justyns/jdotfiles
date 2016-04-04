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
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'

" https://github.com/tpope/vim-sensible
Plug 'tpope/vim-sensible'

" searching / grep - only loaded when invoked
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'rking/ag.vim', { 'on': 'Ag' }

" navigation
Plug 'ctrlpvim/ctrlp.vim'  " , { 'on': ['CtrlP', 'CtrlPBuffer', 'CtrlPMixed'] }

" Syntax hilighting for various things
Plug 'ekalinin/Dockerfile.vim'   " , { 'for': 'dockerfile' }
Plug 'dag/vim-fish'
Plug 'rodjek/vim-puppet'
Plug 'hdima/python-syntax'
Plug 'saltstack/salt-vim'
Plug 'markcornick/vim-vagrant'
Plug 'tpope/vim-markdown'
Plug 'fatih/vim-go'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'vadv/vim-chef'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'klen/python-mode'
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'

" misc plugins
Plug 'stephpy/vim-yaml'   " faster yaml processing for salt files with large lines
Plug 'scrooloose/syntastic'   " syntax checker
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'


call plug#end()
