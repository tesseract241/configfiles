syntax on
set encoding=utf-8
"
"
"VIMPLUG CONFIG BEGIN
"
"
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'sickill/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'icymind/NeoSolarized'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'machakann/vim-sandwich'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'neomake/neomake'
Plug 'c0r73x/neotags.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'sheerun/vim-polyglot'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"
"
"VIMPLUG CONFIG END
"
"
"Show linenumbers
set number
set ruler

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

"Neomake config
call neomake#configure#automake('nrwi', 500)
"Neocomplete config
let g:neocomplete#enable_at_startup = 1
"Airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#number_nr_show = 1
"Deoplete config
let g:deoplete#enable_at_startup = 1
set mouse=a
