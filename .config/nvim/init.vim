"automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'  
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" General settings
set nu
let mapleader=","
set guifont=FiraCode\ Nerd\ Font\ 11

" Theme
set termguicolors
colorscheme dracula

" CoC
let g:coc_global_extensions = ['coc-git', 'coc-json', 'coc-markdownlint', 'coc-python', 'coc-texlab']


" NERDTree
autocmd vimenter * NERDTree " autostart
autocmd VimEnter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" NERDCommenter
let g:NERDSpaceDelims = 1  
let g:NERDTrimTrailingWhitespace = 1 

" Airtable
let g:airline#extensions#tabline#enabled = 1  " show open buffers (as tabs)
let g:airline#extensions#tabline#fnamemod = ':t'  " show only file name

let g:airline_powerline_fonts = 1

set noshowmode  " do not show mode (already shown in airtable) 

" indentline
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']
