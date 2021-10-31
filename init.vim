syntax on
set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'sickill/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'icymind/NeoSolarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jsfaint/gen_tags.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'gennaro-tedesco/nvim-peekup'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'idanarye/vim-vebugger'

call plug#end()

"Show linenumbers
set number
set ruler

" Set syntax-based folds
set foldmethod=syntax
set foldlevelstart=99

" Always show 5 lines above and below the cursor
set scrolloff=5

" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Always display the status line
set laststatus=2

" Enable highlighting of the current line
set cursorline

" Theme and Styling 
set t_Co=256
set background=dark
set termguicolors
let g:solarized_hitrail=1
highlight Folded guibg=grey guifg=blue

"airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

"deoplete config
let g:deoplete#enable_at_startup = 1

"ALE config
let g:ale_hover_to_preview  = 1
nmap <F6> :ALEPreviousWrap <CR>
nmap <F7> :ALENextWrap <CR>
nmap <F8> :ALEDetail <CR>
nmap <F9> :ALEHover <CR>
let g:ale_default_navigation= 'vsplit'
let g:ale_linters_explicit = 1
let g:ale_c_cc_executable = 'g++'
let g:ale_cpp_cc_executable = 'g++'
let g:ale_cpp_cc_options = '-std=c++17 -Wall'
let g:ale_linters = {'c' : ['gcc'], 'cpp' : ['gcc'], 'glsl' : ['glslang']}
let g:ale_fixers = {'c' : ['trim_whitespace'], 'cpp' : ['trim_whitespace']}
let g:ale_c_parse_compile_commands = 0
let g:ale_c_always_make = 1
let g:ale_c_parse_makefile = 1

"User config
set mouse=a
set updatetime=1000
set ignorecase smartcase
:augroup previewTags
    :autocmd!
    :autocmd CursorHold * ++nested :ALEHover
:augroup END
set path+=**,./**,/usr/local/include/**,/usr/include/**

"Python-provided calculator command
:command! -nargs=+ Calc :py print <args>
:py from math import *
