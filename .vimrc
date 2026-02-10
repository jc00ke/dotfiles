" Leader keys
let mapleader = ","
let maplocalleader = "\\"

" General settings
set nohlsearch
set mouse=
set tabstop=2
set expandtab
set nocursorcolumn
set ignorecase
set shiftwidth=2
set smartindent
set nowrap
set number
set relativenumber
set noswapfile
set undofile
set incsearch
set signcolumn=yes
set splitright
set splitbelow

" Enable true colors if available
if has('termguicolors')
  set termguicolors
endif

" Keymaps
nnoremap <leader>o :update<cr>:source %<CR>
inoremap jj <esc>
inoremap kk <esc>:update<cr>
nnoremap <leader>j gT
nnoremap <leader>k gt
noremap <space> <nop>

" Terminal keymaps (Vim 8.1+ terminal support)
if has('terminal')
  nnoremap <leader>fs :botright terminal<cr>
  nnoremap <leader>fv :vertical terminal<cr>
  nnoremap <leader>ff :tab terminal<cr>
  tnoremap <esc> <c-\><c-n>
  tnoremap <c-o> <c-\><c-n>
endif

" Visual mode replace
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
