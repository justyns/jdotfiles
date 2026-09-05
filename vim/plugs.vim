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

" vim-plug itself (adds help files/etc)
Plug 'junegunn/vim-plug'

" Works everywhere, including vim 7.4
Plug 'liuchengxu/space-vim-dark'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'mbbill/undotree'

if v:version >= 800
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'dense-analysis/ale'
endif

" gitgutter needs the async job API that landed in 8.0.902
if has('patch-8.0.902')
    Plug 'airblade/vim-gitgutter'
endif

call plug#end()
