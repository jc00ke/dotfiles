if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'tpope/vim-sensible'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Colors
  Plug 'ap/vim-css-color'

  " Fonts and icons
  Plug 'ryanoasis/vim-devicons'

  " Elm
  Plug 'andys8/vim-elm-syntax', { 'for': 'elm' }

  Plug 'sheerun/vim-polyglot'
  let g:polyglot_disabled = ['elm']
  let g:rustfmt_autosave = 1
  Plug 'vito-c/jq.vim'

  " sessions
  Plug 'tpope/vim-obsession'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'tpope/vim-rhubarb'
  Plug 'idanarye/vim-merginal'
  Plug 'mhinz/vim-signify'
  set updatetime=100

  " text editing
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  let NERDTreeIgnore=['\~$', 'tfstate$', 'tfstate\.backup$']
  Plug 'junegunn/vim-easy-align'

  " Unix
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-dotenv'

  " Ruby
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'tpope/vim-rake', { 'for': 'ruby' }

  " Testing
  Plug 'janko-m/vim-test'
  " https://github.com/janko/vim-test#cli-options
  let g:test#runner_commands = ['ExUnit', 'ElmTest']

  " search
  Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
  Plug 'jremmen/vim-ripgrep'
  "let g:clap_theme = 'solarized_light'
  Plug 'haya14busa/is.vim'

  " color themes & usability
  Plug 'flazz/vim-colorschemes'
  Plug 'Yggdroot/indentLine'
  let g:indentLine_enabled = 0
  map <F9> :IndentLinesToggle<CR>
  Plug 'itchyny/lightline.vim'
  let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ }

  " database
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'

  " Heroku
  Plug 'tpope/vim-heroku'

  " the tab complete thing
  "Plug 'codota/tabnine-vim'

  " Elixir
  Plug 'c-brenn/phoenix.vim', { 'for': 'elixir' }
  Plug 'tpope/vim-projectionist'
  Plug 'powerman/vim-plugin-AnsiEsc'
  Plug 'mhinz/vim-mix-format', { 'for': 'elixir' }
  let g:mix_format_on_save = 1

  " Inko
  Plug 'https://gitlab.com/inko-lang/inko.vim.git', { 'for': 'inko' }

  Plug 'vimlab/split-term.vim'
call plug#end()

" Begin CoC config
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Confirm completion
"inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gR <Plug>(coc-rename)
" Fix autofix problem of current line
nmap <silent> gx <Plug>(coc-fix-current)
" Remap for do codeAction of current line
nmap <silent> ga <Plug>(coc-codeaction)
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"autocmd BufWritePre   *.elm call CocAction('format')
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" End CoC config

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

" run sh since neovim doesn't fully support fish yet
if &shell =~# 'fish$'
  set shell=sh
endif

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

" Files and folders to ignore
set wildignore=*/.git/*
set wildignore+=*/tmp/*
set wildignore+=*.swp
set wildignore+=*/.DS_Store
set wildignore+=*/vendor
set wildignore+=*/env/*
set wildignore+=*/deps/* " Elixir deps
set wildignore+=*/_build/* " Elixir builds
set wildignore+=*/elixir_ls/* " Elixir language server files
set wildignore+=*/node_modules/*
set wildignore+=*/elm-stuff/*
set wildignore+=*/staticfiles/*
set wildignore+=*.gch
set wildignore+=*.o
set wildignore+=*.crdownload

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

" vim-easy-align
" start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>v <Plug>(EasyAlign)

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" BEGIN vim-test
let test#strategy = "neovim"
tmap <C-o> <C-\><C-n>

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
" END vim-test

" Clap searching
nnoremap <C-p> :Clap files<CR>
nnoremap <Leader>a :Clap grep<CR>
nnoremap <Leader>A :Clap grep ++query=<cword><CR>

" merginal
nmap <Leader>o :MerginalToggle<CR>

" allow terminal buffer size to be very large
let g:terminal_scrollback_buffer_size = 100000

" map esc to exit to normal mode in terminal too
tnoremap <Esc><Esc> <C-\><C-n>

" Jump and Create splits easily
nmap <Leader>fs :Term<CR>
nmap <Leader>fv :VTerm<CR>
nmap <Leader>ff :TTerm<CR>
let g:split_term_default_shell = "fish"

au FileType elixir nnoremap io o\|> IO.inspect(printable_limit: :infinity)<Esc>
au FileType elixir nnoremap IO o\|> IO.inspect(label: "", printable_limit: :infinity)<Esc>F"i
au FileType elixir nnoremap ii a \|> IO.inspect(printable_limit: :infinity)<Esc>i
au FileType elixir nnoremap II a \|> IO.inspect(label: "", printable_limit: :infinity)<Esc>F"i
au FileType elixir nnoremap <leader>r orequire IEx; IEx.pry<esc>
au FileType ruby map <Leader>fsl gg O# frozen_string_literal: true<CR><Esc>x
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd Filetype elm setlocal ts=4 sw=4 sts=4 expandtab nowrap

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
