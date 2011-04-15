" Folding cheet sheet 
" zR    open all folds
" zM    close all folds
" za    toggle fold at cursor position
" zj    move down to start of next fold
" zk    move up to end of previous fold
" Manage plugins. {{{1
runtime macros/matchit.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
let g:GetLatestVimScripts_allowautoinstall=1

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50               " Keep 50 history items
set ruler                    " Always show cursor position
set showcmd                  " Show incorrect commands
set incsearch                " Start searching immediately















" Enable line numbers
set number
" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" Use indent plugin to keep python indenting at ease
" filetype plugin indent on

" Correct syntax on python files
" autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

syntax on
set ts=3 sts=3 sw=3 noexpandtab

color molokai
