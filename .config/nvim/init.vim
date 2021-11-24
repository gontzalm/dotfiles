" PLUGIN MANAGER
" install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocm~ vimenter * PlugInstall --sync | source $MYVIMRC
endif

" run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
    \| endif

" PLUGINS
call plug#begin('~/.config/nvim/plugged')

" aesthetics
Plug 'sainnhe/edge'
" Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'vim-airline/vim-airline'

" lsp, completion, syntax highlighting, style
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" documentation
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" git
Plug 'tpope/vim-fugitive'

" must-have utilities
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'farmergreg/vim-lastplace'
Plug 'romainl/vim-cool'
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall', 'branch': 'main'}

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" filetype plugins
Plug 'lervag/vimtex'

call plug#end()

" GENERAL SETTINGS
" basics
set ignorecase
set hidden
set number
set autoindent
let g:vim_indent_cont = shiftwidth()
filetype plugin indent on

" commands
command Config e ~/.config/nvim/init.vim

" abbreviations
cnoreabbrev vb vertical sbuffer
cnoreabbrev h vertical help

" keep cursor centered vertically
nnoremap j jzz
nnoremap k kzz

" hard-wrap text at 80 characters
set textwidth=80
set linebreak

" replace tabs with spaces
autocmd FileType * set softtabstop=4 shiftwidth=4 expandtab
autocmd FileType sh,json set softtabstop=2 shiftwidth=2 expandtab

" display special characters with symbols
set list
set listchars=eol:⏎,tab:-->,trail:␠,nbsp:⎵

" leader key
let mapleader=','
let maplocalleader=','

" natural splits & window navigation
set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" create non existing directories when writing a file
autocmd BufWritePre *
    \ if '<afile>' !~ '^scp:' && !isdirectory(expand('<afile>:h')) |
        \ call mkdir(expand('<afile>:h'), 'p') |
    \ endif

" PLUGIN CONFIG
" theme
set termguicolors
let g:edge_style = 'neon'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
colorscheme edge

" airline
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'edge'
set noshowmode

" commentary
autocmd FileType toml setlocal commentstring=#\ %s

" fugitive
set statusline+=%{FugitiveStatusline()}

" doge
let g:doge_doc_standard_python = 'google'

" glow
noremap <leader>p :Glow<CR>

" CoC
" basics
set updatetime=300
set shortmess+=c
set signcolumn=number
let g:coc_global_extensions = [
    \ 'coc-docker',
    \ 'coc-explorer',
    \ 'coc-git',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-markdownlint',
    \ 'coc-pairs',
    \ 'coc-prettier',
    \ 'coc-pyright',
    \ 'coc-rust-analyzer',
    \ 'coc-sh',
    \ 'coc-sql',
    \ 'coc-toml',
    \ 'coc-vimlsp',
    \ 'coc-vimtex',
    \ 'coc-yaml'
    \ ]

" navigate completion with tabs
inoremap <silent> <expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" improve <CR> with coc-pairs
inoremap <silent> <expr> <CR> "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

" mappings
nmap <silent> <C-e> :CocCommand explorer<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>fb <Plug>(coc-format)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>ab <Plug>(coc-codeaction)
nmap <silent> <leader>ac <Plug>(coc-codeaction-cursor)

" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    }
}
EOF
nnoremap <Space> za
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" telescope
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fh :Telescope help_tags<CR>
nnoremap <leader>gc :Telescope git_commits<CR>
nnoremap <leader>gs :Telescope git_status<CR>

" vimtex
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'build',
    \ }
