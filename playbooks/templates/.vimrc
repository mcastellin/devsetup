" Gotta be first
set nocompatible
filetype off " required

" set the runtime path to include Vundle and initialise
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()         " required

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" all plugins installation here
Plugin 'valloric/youcompleteme'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'     " surround text with tags and parenthesis
Plugin 'ctrlpvim/ctrlp.vim'     " fuzzy search in vim
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'ryanoasis/vim-devicons'
Plugin 'chiel92/vim-autoformat'
Plugin 'nvie/vim-flake8'
Plugin 'hashivim/vim-terraform'
Plugin 'junegunn/limelight.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ntk148v/komau.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'cocopon/iceberg.vim'
Plugin 'Konfekt/FastFold'
Plugin 'w0rp/ale'
Plugin 'preservim/vimux'
Plugin 'mcastellin/vim-pyShell'
Plugin 'julienr/vim-cellmode'
Plugin 'fatih/vim-go'


" all plugins must be added before this line
call vundle#end()           " required 
filetype plugin indent on   " required

" Use `git grep` for file search
set gp=git\ grep\ -n

" git-gutter sign column background color fix
highlight! link SignColumn LineNr
autocmd ColorScheme * highlight! link SignColumn LineNr

" NERDTree plugin configuration
let NERDTreeShowHidden=1
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/

" Use pipenv virtual environment when available
let pipenv_venv_path = system('pipenv --venv')
" the above system() call produces a non zero exit code whenever
" a valid virtual environment has been found
if shell_error == 0
    let venv_path = substitute(pipenv_venv_path, '\n', '', '')
    let g:ycm_python_interpreter_path = venv_path . '/bin/python'
    let g:ycm_python_sys_path = [ venv_path ]
else
    let g:ycm_python_interpreter_path = '/usr/bin/python'
    let g:ycm_python_sys_path = [ ]
endif

" if we have .venv folder in this directory, then we use this virtual
" environment
let pipenv_venv_path = system('realpath .venv')
if shell_error == 0
    let venv_path = substitute(pipenv_venv_path, '\n', '', '')
    let g:ycm_python_interpreter_path = venv_path . '/bin/python'
    let g:ycm_python_sys_path = [ venv_path ]
endif

" configure YCM server with global extra conf so we don't need to have an
" ycm_extra_conf.py file in every project directory
let g:ycm_extra_conf_vim_data = [ 'g:ycm_python_interpreter_path', 'g:ycm_python_sys_path' ]
let g:ycm_global_ycm_extra_conf = '~/.vim/global_extra_conf.py'

" additional YCM plugin settings
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


" ---- NERDTree settings ----
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" ---- Vim-autoformat settings ----
let g:formatters_python = ["black"]

" ---- Python settings ----
setlocal path=.,**
setlocal wildignore=*.pyc

" ---- General Settings ----
set noswapfile
"set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set splitbelow
set splitright

syntax on
set encoding=UTF-8

set background=dark
set mouse=a
