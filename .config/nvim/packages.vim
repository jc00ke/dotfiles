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
