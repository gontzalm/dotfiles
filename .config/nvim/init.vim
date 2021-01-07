" automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimenter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" PLUGIN MANAGER
call plug#begin('~/.config/nvim/plugged')

" Aesthetics
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons' "vim-devicons must always be last

" Completion, syntax highlighting, style
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'Vimjas/vim-python-pep8-indent'

" Explorer
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Must-have utilities
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Filetype plugins
Plug 'lervag/vimtex'

" Other
Plug 'junegunn/goyo.vim'

call plug#end()

" GENERAL SETTINGS
" Basics
set number
set scrolloff=1

" Hard-wrap text at 80 characters
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

"" Keybindings
let mapleader=','
let maplocalleader=','
nnoremap <silent> <leader>h :noh<CR> " toggle highlighting

" Splits
set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" PLUGINS
" Theme
set termguicolors
colorscheme challenger_deep

" Airline
let g:airline#extensions#tabline#enabled = 1  " show open buffers (as tabs)
let g:airline#extensions#tabline#fnamemod = ':t'  " show only file name

let g:airline_powerline_fonts = 1

set noshowmode  " do not show mode (already shown in airtable)

" CoC
let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-markdownlint', 'coc-python', 'coc-vimtex']
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"     " tab navigation
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" " tab navigation

" NERDTree
autocmd vimenter * NERDTree " autostart
autocmd vimenter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {'python': {'left': '#'}}
let g:NERDTrimTrailingWhitespace = 1

" IndentLine
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

" VimTex
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : 'build',
      \}
