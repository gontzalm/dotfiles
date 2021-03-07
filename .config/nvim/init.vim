" automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimenter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" PLUGIN MANAGER
call plug#begin('~/.config/nvim/plugged')

" aesthetics
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'

" completion, syntax highlighting, style
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jiangmiao/auto-pairs'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" tree
Plug 'preservim/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" must-have utilities
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'

" filetype plugins
Plug 'lervag/vimtex'

" others
Plug 'junegunn/goyo.vim'

call plug#end()

" GENERAL SETTINGS
" basics
set number relativenumber
set hidden
cnoreabbrev vb vertical sbuffer

" open help in new window
command -nargs=1 -complete=help Help vertical help <args>
cnoreabbrev h Help

" keep cursor centered vertically
nnoremap j jzz
nnoremap k kzz

" hard-wrap text at 80 characters
set textwidth=80
set wrapmargin=0
set formatoptions+=t
set linebreak

" Replace tabs with spaces
autocmd filetype * set softtabstop=2 | set shiftwidth=2 | set expandtab
autocmd filetype python,markdown,tex,vim set softtabstop=4 | set shiftwidth=4 | set expandtab

" Display special characters with symbols
set list
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵

" leader key
let mapleader=','
let maplocalleader=','

" toggle highlighting
nnoremap <silent> <leader>h :noh<cr>

" natural splits & window navigation
set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" create non existing directories when writing a file
autocmd bufwritepre *
    \ if '<afile>' !~ '^scp:' && !isdirectory(expand('<afile>:h')) |
        \ call mkdir(expand('<afile>:h'), 'p') |
    \ endif

" PLUGINS
" theme
set termguicolors
colorscheme challenger_deep

" airline
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
set noshowmode

" fugitive
set statusline+=%{FugitiveStatusline()}

" coc
set updatetime=300
set shortmess+=c
let g:coc_global_extensions = [
    \ 'coc-git',
    \ 'coc-json',
    \ 'coc-markdownlint',
    \ 'coc-pyright',
    \ 'coc-vimtex'
    \ ]
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>"
inoremap <expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <expr> <S-tab> pumvisible() ? "\<C-p>" : "\<S-tab>"

command -nargs=0 Format call CocAction('format')
nnoremap <leader>a :CocAction<cr>

" simpylfold
nnoremap <space> za
let g:SimpylFold_docstring_preview = 1

" fastfold
let g:fastfold_minlines = 0

" nerdtree
autocmd vimenter * NERDTree
autocmd vimenter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<cr>
let NERDTreeShowHidden = 1

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {'python': {'left': '#'}}
let g:NERDTrimTrailingWhitespace = 1

" indentline
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

" vimtex
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'build',
    \ }
