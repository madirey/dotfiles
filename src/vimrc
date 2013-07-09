" Vim mode
set nocompatible

" Hide buffers, don't close them
set hidden

" Initialize vundle plugin manager
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Vundle plugins
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-fugitive'
Bundle 'reinh/vim-makegreen'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'myusuf3/numbers.vim'
Bundle 'mattcaldwell/python-mode'
Bundle 'mattcaldwell/vim-github-comment'
Bundle 'tpope/vim-surround'
Bundle 'majutsushi/tagbar'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'twilight'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'Valloric/YouCompleteMe'
Bundle 'suan/vim-instant-markdown'

" Functions
function! g:ToggleLineNumberMode()
    if(&nu==1)
        set rnu
    elseif(&rnu==1)
        set nornu
    else
        set nu
    endif
endfunc

" Indent based on filetype
filetype plugin indent on

" Syntax highlighting and color scheme
syntax on
colorscheme twilight
highlight Pmenu ctermfg=0 ctermbg=2
highlight PmenuSel ctermfg=0 ctermbg=7

" Customize leader
let mapleader = ','

" Autocompletion
"if has('autocmd')
"    autocmd FileType python set omnifunc=pythoncomplete#Complete
"    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"endif
"set completeopt=menuone,longest,preview

" Basic editor settings (and PEP8)
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set autoindent
set copyindent
set ignorecase
set smartcase
set smarttab
set nowrap
set cursorline
set backspace=indent,eol,start

set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells

" Backups and swap files
silent !mkdir ~/tmp > /dev/null 2>&1
set backup
set swapfile
set backupdir=~/tmp
set dir=~/tmp

" Mappings -----------------------------------------
"
" display file explorer
map <C-d> :NERDTreeToggle<CR>
" display tags
map <C-t> :TagbarToggle<CR>
" toggle absolute/relative line numbers
map <C-n> :call g:ToggleLineNumberMode()<CR>
" clear highlighting
map <C-g> :noh<CR>
" clear search
map <C-s> :let @/ = ""<CR>
" toggle list
map <C-l> :set list!<CR>
" django tests
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
" django server
map <leader>rs :set makeprg=python\ manage.py\ runserver<CR>
" nose tests
map <leader>rt :!nosetests --with-coverage<CR>
" window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"
" End Mappings -------------------------------------

" Status Line
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " git branch
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

" Search
set hlsearch
set incsearch

" Whitespace
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
if has('autocmd')
    autocmd filetype html,xml set listchars-=tab:>.
endif

" Toggle paste mode
set pastetoggle=<F2>

" Forget to sudo?
cmap w!! w !sudo tee % >/dev/null

" Python
" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Indent Guides
:let g:indent_guides_guide_size = 1
:let g:indent_guides_start_level = 2

" Python-mode
let g:pymode_folding = 0
let g:pymode_lint_ignore = "E125,E126,E127,E128,E201,E202,E225,E226,E227,E228,E231,E301,E302,E502"
let g:pymode_lint_maxlinelength = 119
map <leader>j :RopeGotoDefinition<CR>

" git
let g:github_user = "mattcaldwell"

" ctrl-p
let g:ctrlp_map = '<leader>f'
" <F5> - refresh

" search/replace
map <leader>n :cn<CR>
map <leader>p :cp<CR>
