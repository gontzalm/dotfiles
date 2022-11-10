" = PLUGINS =

" PLUGIN MANAGER
" automatic installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocm~ vimenter * PlugInstall --sync | source $MYVIMRC
endif

" install missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
    \| endif

" PLUGIN LIST
call plug#begin('~/.config/nvim/plugged')

" aesthetics
Plug 'sainnhe/edge'
" Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'vim-airline/vim-airline'

" lsp, completion, syntax highlighting, style
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" documentation
Plug 'kkoomen/vim-doge', {'do': {-> doge#install()}}

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
Plug 'fannheyward/telescope-coc.nvim'

" filetype plugins
Plug 'lervag/vimtex'
Plug 'vimjas/vim-python-pep8-indent'

call plug#end()

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

" conqueror of comletion (coc)
" coc: basics
set nobackup nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=number

" coc: extensions
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
    \ 'coc-toml',
    \ 'coc-vimlsp',
    \ 'coc-vimtex',
    \ 'coc-yaml'
    \ ]

" coc: navigate completion with tabs
inoremap <silent> <expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc: improve <CR> with coc-pairs
inoremap <silent> <expr> <CR> "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

" coc: navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" coc: code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)

" coc: mappings
nmap <silent> <C-e> :CocCommand explorer<CR>
nmap <silent> <leader>a <Plug>(coc-codeaction-selected)
xmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>ab <Plug>(coc-codeaction)
nmap <silent> <leader>ac <Plug>(coc-codeaction-cursor)
nmap <silent> <leader>al <Plug>(coc-codeaction-line)
nmap <silent> <leader>fb <Plug>(coc-format)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
nmap <silent> <leader>rn <Plug>(coc-rename)

" coc: use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'vertical help '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" coc: map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a) 

" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "comment",
        "dockerfile",
        "html",
        "json",
        "jsonc",
        "latex",
        "lua",
        "markdown",
        "python",
        "regex",
        "rust",
        "toml",
        "vim",
        "yaml"
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = {"python"},
    }
}
EOF
nnoremap <Space> za
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" telescope
lua << EOF
require('telescope').load_extension('coc')
EOF
nnoremap <silent> <leader>ff :Telescope find_files<CR>
nnoremap <silent> <leader>fg :Telescope live_grep<CR>
nnoremap <silent> <leader>gc :Telescope git_commits initial_mode=normal<CR>
nnoremap <silent> <leader>gs :Telescope git_status initial_mode=normal<CR>
nnoremap <silent> <leader>fs :Telescope treesitter initial_mode=normal<CR>
nnoremap <silent> <leader>fc :Telescope coc commands<CR>
nnoremap <silent> <leader>fd :Telescope coc diagnostics initial_mode=normal<CR>
nnoremap <silent> <leader>fr :Telescope coc references initial_mode=normal<CR>

" vimtex
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'build',
    \ }


" = GENERAL SETTINGS =

" BASICS
set ignorecase
set hidden
set number
set autoindent
set linebreak
set list
set listchars=eol:⏎,tab:-->,trail:␠,nbsp:⎵
let mapleader=','
let maplocalleader=','
let g:vim_indent_cont = shiftwidth()

" COMMANDS
command Config e ~/.config/nvim/init.vim

" ABBREVIATIONS
cnoreabbrev vb vertical sbuffer
cnoreabbrev h vertical help

" MAPPINGS
nnoremap j jzz
nnoremap k kzz

" TABS/SPACES
autocmd FileType * set softtabstop=4 shiftwidth=4 expandtab
autocmd FileType sh,json,markdown,yaml set softtabstop=2 shiftwidth=2 expandtab

" SPLITS
set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" OTHERS
" create non existing directories when writing a file
autocmd BufWritePre *
    \ if '<afile>' !~ '^scp:' && !isdirectory(expand('<afile>:h')) |
        \ call mkdir(expand('<afile>:h'), 'p') |
    \ endif
