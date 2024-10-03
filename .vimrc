""" Setup vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'drmikehenry/vim-fontsize'
Plug 'mechatroner/rainbow_csv'
Plug 'tpope/vim-surround'
call plug#end()

""" Settings
set autoread
set incsearch
set nobackup
set nowb
set noswapfile
set cursorline
set number
set ruler
set textwidth=80
set formatoptions-=t
set so=5 "Enable vertical shifting x lines from top/bottom of screen
set ignorecase
set autoindent
set smartindent
set expandtab
set hlsearch
set magic
set tabstop=4
set shiftwidth=4
set splitbelow "Splits below when using :term
set linespace=1
set encoding=utf-8
set guifont=Consolas:h12:cANSI:qDRAFT
set backspace=indent,eol,start
set colorcolumn=80,100
set ttimeoutlen=0
set laststatus=2
set foldmethod=syntax
set foldlevel=99 "Open all folds by default
filetype on
filetype plugin indent on
if !exists("g:syntax_on") "https://stackoverflow.com/a/33380495
    syntax enable
endif

""" Remove audible beeping in certain situations (e.g pressing ESC)
set visualbell
set noerrorbells
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif
set belloff=all

""" Sets line cursor on insert, block cursor on command
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
augroup myCmds
    au!
    autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
let g:airline_theme="alduin"

""" Set indentation based on currently open file
let g:python_indent = {}
let g:python_indent.open_paren = 'shiftwidth()'
let g:python_indent.closed_paren_align_last_line = v:false
augroup FileTypeSettings
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
    autocmd FileType c setlocal tabstop=8 shiftwidth=8
    autocmd FileType cpp setlocal tabstop=4 shiftwidth=4
    autocmd FileType cs setlocal tabstop=4 shiftwidth=4
    autocmd FileType json setlocal tabstop=4 shiftwidth=4
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
augroup END

""" Colorscheme
if (has("termguicolors"))
    set termguicolors
endif
colorscheme slate
highlight MatchParen cterm=underline ctermbg=black ctermfg=white
highlight MatchParen gui=underline guibg=black guifg=white
highlight Search cterm=NONE ctermfg=black ctermbg=yellow
