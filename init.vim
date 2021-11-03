syntax on
set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'sickill/vim-monokai'
Plug 'haystackandroid/carbonized'
Plug 'altercation/vim-colors-solarized'
Plug 'icymind/NeoSolarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
"Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'jsfaint/gen_tags.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'gennaro-tedesco/nvim-peekup'
Plug 'airblade/vim-gitgutter'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

call plug#end()

"Show linenumbers
set number
set relativenumber
set ruler

" Set substitute to always replace all occurences on a line
set gdefault
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
set background=dark
set termguicolors
colorscheme dawn
let g:solarized_hitrail=1

"airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme='alduin'
let g:airline_solarized_bg='dark'

"lsp config
lua << EOF

local lspconfig = require('lspconfig')
require('coq_3p'){
     { src = "nvimlua", short_name = "nLUA", conf_only = false },
     { src = "bc", short_name = "MATH", precision = 6 },
}
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<F4>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<F3>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'gopls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  } 
end
--[[lspconfig.ccls.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = function(fname) 
    return vim.fn.getcwd()
  end,
     -- function(startpath)
        local function root_pattern(startpath)
            lspconfig.util.root_pattern('build', 'subprojects')(startpath)
        end
        local me = root_pattern(startpath) or startpath
        local ancestor = root_pattern(lspconfig.util.path.dirname(me)) or me
        repeat
        me = ancestor
        ancestor = root_pattern(lspconfig.util.path.dirname(me)) or me
        until ancestor~=me
    end, --
  init_options = {
    compilationDatabaseDirectory = "build",
    diagnostics = {
      onChange = 2000,
    },
    index = {
      comments = 0,
      threads = 0,
      trackDependency = 1,
    },
  }
} ]]--
lspconfig.clangd.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = function(fname) 
    return vim.fn.getcwd()
  end,
  init_options = {
    compilationDatabaseDirectory = "build",
    diagnostics = {
      onChange = 2000,
    },
  }
}
EOF

"COQ config
let g:coq_settings = {'auto_start' : 'shut-up'}

"User config
set mouse=a
set updatetime=1000
set ignorecase smartcase
set path+=**,/usr/local/include/**,/usr/include/**

"Python-provided calculator command
":command! -nargs=+ Calc :py print <args>
":py from math import *

"nvimgdb config
let g:nvimgdb_termwin_command = "belowright vnew"
let g:nvimgdb_codewin_command = "vnew"
let g:nvimgdb_key_breakpoint='<F8>'
let g:nvimgdb_key_next='<F7>'
let g:nvimgdb_key_step='<F8>>'

:autocmd User NvimGdbQuery :bo :GdbLopenBacktrace
