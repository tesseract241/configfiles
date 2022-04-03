syntax on
set encoding=utf-8

packadd! matchit
call plug#begin('~/.vim/plugged')

Plug 'sickill/vim-monokai'
Plug 'haystackandroid/carbonized'
Plug 'altercation/vim-colors-solarized'
Plug 'icymind/NeoSolarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovim/nvim-lspconfig'
Plug 'yegappan/mru'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
Plug 'airblade/vim-gitgutter'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'yggdroot/indentline'
Plug 'mbbill/undotree'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'dylon/vim-antlr'

call plug#end()

"Show linenumbers
set number
set relativenumber
set ruler

"Making [count]~ change count characters' case instead of one and then moving count characters forward
set tildeop

"Making :make call meson
set makeprg=meson\ compile\ -C\ build

"Using ugrep for searching
if executable('ugrep')
    set grepprg=ugrep\ -RInk\ -j\ -u\ --tabs=1\ --ignore-files
    set grepformat=%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\\|%l\\\|%c\\\|%m
    set runtimepath^=~/.vim/bundle/ctrlp.vim
    let g:ctrlp_match_window='bottom,order:ttb'
    let g:ctrlp_user_command='ugrep "" %s -Rl -I --ignore-files -3'

"Using ripgrep for searching
elseif executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    set runtimepath^=~/.vim/bundle/ctrlp.vim
    let g:ctrlp_match_window='bottom,order:ttb'
    let g:ctrlp_user_command='rg "" %s -l --no-binary'
endif

"Vim file explorer configuration
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_liststyle = 3
let g:netrw_winsize=-25 

"Make hidden buffers not abandoned
set hidden

"Ask to save modified files instead of failing the command
set confirm

"Split will split to the right
set splitright

"Let undo trees persist after vim closes
set undofile
set undodir=.

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

"Autoindent lines according to C style
set autoindent
set cindent

" Always display the status line
set laststatus=2

" Enable highlighting of the current line
set cursorline

" Theme and Styling 
set background=dark
set termguicolors
colorscheme dawn
"let g:solarized_hitrail=1

"airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'
let g:airline_inactive_alt_sep=1
let g:airline_exclude_preview = 0
let g:airline#extensions#tabline#buffer_nr_show = 1

"rainbow_parentheses config
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

"lsp config
lua << EOF

--uncomment this to generate debug messages and then read them with :lua vim.cmd('e'..vim.lsp.get_log_path())
--vim.lsp.set_log_level("debug")

local lspconfig = require('lspconfig')
require('coq_3p'){
     { src = "nvimlua", short_name = "nLUA", conf_only = false },
     { src = "bc", short_name = "MATH", precision = 6 },
}
local on_attach = function(client, bufnr)
  --vim.cmd('cd build')
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
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<F3>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'gopls'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    root_dir = lspconfig.util.root_pattern('build/compile_commands.json', '.git')
} 
end
  --[[
lspconfig.ccls.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
 root_dir = function(fname) 
    return vim.fn.getcwd()
  --root_dir = function(fname) 
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
    end,--
  end, 
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
    },]]--
lspconfig.clangd.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    root_dir = lspconfig.util.root_pattern('build/compile_commands.json', '.git'),
    cmd = { 'clangd', '--background-index', '--compile-commands-dir=build'},
    clang = {excludeArgs = {"-falign-jumps=1","-falign-loops=1","-fconserve-stack","-fmerge-constants","-fno-code-hoisting","-fno-schedule-insns","-fno-sched-pressure","-fno-var-tracking-assignments","-fsched-pressure","-mhard-float","-mindirect-branch-register","-mindirect-branch=thunk-inline","-mpreferred-stack-boundary=2","-mpreferred-stack-boundary=3","-mpreferred-stack-boundary=4","-mrecord-mcount","-mindirect-branch=thunk-extern","-mno-fp-ret-in-387","-mskip-rax-setup","--param=allow-store-data-races=0","-Wa,arch/x86/kernel/macros.s","-Wa,-"},
    extraArgs = {"--gcc-toolchain=/usr"}}
}
EOF

"COQ config
let g:coq_settings = {'auto_start' : 'shut-up'}

"indentLine config
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['text']
let g:indentLine_bufTypeExclude = ['quickfix', 'directory', 'help', 'terminal']
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
"let g:indentLine_char = '┊'

"undotree config
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_SplitWidth = 50
let g:undotree_SetFocusWhenToggle = 1

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

"Remaps
nnoremap ò( [(
nnoremap òò [[
nnoremap òà []
nnoremap òi [i
nnoremap òm [m
nnoremap òp [p
nnoremap òz [z
nnoremap òè [{
nnoremap à) ]à
nnoremap àI àI 
nnoremap àò ][
nnoremap àà ]]
nnoremap ài ]i
nnoremap àm ]m
nnoremap àp ]p
nnoremap àz ]z
nnoremap à} ]ù
nnoremap ù <C-]>
nnoremap è {
nnoremap ì }

"autocommands
augroup mycommands
    autocmd!
    autocmd User NvimGdbQuery :bo :GdbLopenBacktrace
    "Open file browser if given no file arguments
    autocmd VimEnter * if !argc() | Vexplore | endif
    "Highlight on yank
    au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
    "au VimEnter * silent! cd build
    "Remember cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
                \ endif
augroup END

