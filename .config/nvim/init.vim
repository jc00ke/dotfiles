" Indentation
set tabstop=2
set shiftwidth=2
set expandtab
retab
set formatoptions+=w
set smartindent

set modeline

" don't wrap long lines
set nowrap

" highlight the current line
set cursorline

" better splits
set splitright
set splitbelow
"
" folds
set foldmethod=indent
set foldcolumn=0
set foldnestmax=8
set foldlevel=3

" backups
set nobackup
set nowritebackup
set noswapfile

" line numbers
set number relativenumber

" flash don't audibly beep
set noerrorbells
set visualbell

" omnicompletion
set completeopt-=preview

source $HOME/.config/nvim/packages.vim
source $HOME/.config/nvim/coc.vim
source $HOME/.config/nvim/elixir.vim
source $HOME/.config/nvim/ruby.vim
source $HOME/.config/nvim/json.vim
source $HOME/.config/nvim/elm.vim
source $HOME/.config/nvim/ignores.vim
source $HOME/.config/nvim/testing.vim
source $HOME/.config/nvim/clap.vim
source $HOME/.config/nvim/git.vim
source $HOME/.config/nvim/terminal.vim

let g:indent_guides_auto_colors=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" match Github's text width
set tw=110
let &colorcolumn=join(range(111,999),",")
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
" show unprintable characters
set list
set listchars=tab:»\ ,nbsp:෴,trail:※

" show commands while they are being typed
set showcmd

let mapleader=","
let localleader="\\"

"autocmd BufWritePre * :%s/\s\+$//e

if has("autocmd")
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

map f80 gggqG<CR>
map <F2> :NERDTreeToggle<CR>
map <F3> :set go-=m go-=T <CR>
map <F4> :set go+=m go+=T <CR>
nmap <F8> :TagbarToggle<CR>
inoremap jj <Esc>
inoremap kk <Esc>:w<CR>
nnoremap <Leader>j gT
nnoremap <Leader>k gt
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum
set termguicolors
set t_Co=256
"set background=light
colorscheme solarized8_dark

" easy vimrc editing
autocmd bufwritepost init.vim source $MYVIMRC
autocmd bufwritepost init.vim :set nohlsearch

nmap gx yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END
