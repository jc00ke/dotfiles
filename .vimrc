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

" Configure ripgrep as the grep program
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" File and grep keymaps using fd and rg
" <C-p> - Fuzzy file picker using fd
nnoremap <C-p> :call FdFilePicker()<CR>

" <leader>a - Live grep (opens quickfix with rg results)
nnoremap <leader>a :call RipgrepPrompt()<CR>

" <leader>A - Grep word under cursor
nnoremap <leader>A :call RipgrepWordUnderCursor()<CR>

" Function: fd file picker
function! FdFilePicker()
  let files = systemlist('fd --type f --hidden --exclude .git')
  if v:shell_error
    echo "fd not found or error occurred"
    return
  endif
  if len(files) == 0
    echo "No files found"
    return
  endif
  " Use inputlist for simple selection
  let choice = inputlist(['Select file:'] + map(copy(files), 'v:key + 1 . ". " . v:val'))
  if choice > 0 && choice <= len(files)
    execute 'edit' fnameescape(files[choice - 1])
  endif
endfunction

" Function: ripgrep with prompt
function! RipgrepPrompt()
  let pattern = input('Grep for: ')
  if pattern != ''
    execute 'silent grep!' pattern
    copen
    redraw!
  endif
endfunction

" Function: ripgrep word under cursor
function! RipgrepWordUnderCursor()
  let word = expand('<cword>')
  if word != ''
    execute 'silent grep!' shellescape(word)
    copen
    redraw!
  endif
endfunction

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
