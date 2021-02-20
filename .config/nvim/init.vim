" automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimenter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" PLUGIN MANAGER
call plug#begin('~/.config/nvim/plugged')

" aesthetics
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

" completion, syntax highlighting, style
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'Vimjas/vim-python-pep8-indent'

" tree
Plug 'preservim/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" must-have utilities
Plug 'preservim/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" filetype plugins
Plug 'lervag/vimtex'

" Other
Plug 'junegunn/goyo.vim'

call plug#end()

" GENERAL SETTINGS
" basics
set number

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
autocmd filetype python,markdown,tex set softtabstop=4 | set shiftwidth=4 | set expandtab

" Display special characters with symbols
set list
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵

" leader key
let mapleader=','
let maplocalleader=','

" toggle highlighting
nnoremap <silent> <leader>h :noh<CR>

" natural splits & navigation
set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" PLUGINS
" theme
set termguicolors
colorscheme challenger_deep

" airline
let g:airline#extensions#tabline#enabled = 1  " show open buffers (as tabs)
let g:airline#extensions#tabline#fnamemod = ':t'  " show only file name

let g:airline_powerline_fonts = 1

set noshowmode  " do not show mode (already shown in airtable)

" coc
let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-markdownlint', 'coc-pyright', 'coc-vimtex']
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" nerdtree
autocmd vimenter * NERDTree " autostart
autocmd vimenter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
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
      \}
