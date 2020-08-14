if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'tpope/vim-sensible'

  " CoC
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'amiralies/coc-elixir', {'do': 'yarn install && yarn clean && yarn build'}
  Plug 'fannheyward/coc-markdownlint',  {'do': 'yarn install --frozen-lockfile'}
  Plug 'fannheyward/coc-marketplace', {'do': 'yarn install --frozen-lockfile'}
  Plug 'fannheyward/coc-sql', {'do': 'yarn install --frozen-lockfile'}
  Plug 'iamcco/coc-diagnostic',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
  Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
  Plug 'kristijanhusak/vim-dadbod-completion', {'do': 'yarn install --frozen-lockfile'}
  Plug 'joenye/coc-cfn-lint', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
  "Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}

  " Colors
  Plug 'ap/vim-css-color'

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

  " Markdown
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

  " Unix
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-dotenv'

  " Ruby
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'tpope/vim-rake', { 'for': 'ruby' }

  " Testing
  Plug 'vim-test/vim-test'
  " https://github.com/vim-test/vim-test#cli-options
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
  autocmd User DBUIOpened let b:dotenv = DotenvRead('.envrc') | norm R
  let g:db_ui_save_location = './exploration'
  let g:completion_matching_strategy_list = ['exact', 'substring']

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

  Plug 'kburdett/vim-nuuid'

  Plug 'direnv/direnv.vim'
call plug#end()
