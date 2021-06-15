local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local indent = 2

--[[
  Resources

  * https://alpha2phi.medium.com/neovim-init-lua-e80f4f136030
  * https://github.com/akinsho/nvim-toggleterm.lua
  * https://github.com/icyphox/dotfiles/tree/master/config/nvim
  * https://github.com/mjlbach/defaults.nvim/blob/master/init.lua
  * https://github.com/mjlbach/nix-dotfiles/blob/master/nixpkgs/configs/neovim/init.lua
  * https://github.com/nanotee/nvim-lua-guide
  * https://github.com/rockerBOO/awesome-neovim
  * https://icyphox.sh/blog/nvim-lua/
  * https://oroques.dev/notes/neovim-init/

  ╭────────────────────────────────────────────────────────────────────────────────────────────────────╮
  │  String value  │  Help page   │  Affected modes                           │  Vimscript equivalent  │
  │────────────────────────────────────────────────────────────────────────────────────────────────────│
  │  ''            │  mapmode-nvo │  Normal, Visual, Select, Operator-pending │  :map                  │
  │  'n'           │  mapmode-n   │  Normal                                   │  :nmap                 │
  │  'v'           │  mapmode-v   │  Visual and Select                        │  :vmap                 │
  │  's'           │  mapmode-s   │  Select                                   │  :smap                 │
  │  'x'           │  mapmode-x   │  Visual                                   │  :xmap                 │
  │  'o'           │  mapmode-o   │  Operator-pending                         │  :omap                 │
  │  '!'           │  mapmode-ic  │  Insert and Command-line                  │  :map!                 │
  │  'i'           │  mapmode-i   │  Insert                                   │  :imap                 │
  │  'l'           │  mapmode-l   │  Insert, Command-line, Lang-Arg           │  :lmap                 │
  │  'c'           │  mapmode-c   │  Command-line                             │  :cmap                 │
  │  't'           │  mapmode-t   │  Terminal                                 │  :tmap                 │
  ╰────────────────────────────────────────────────────────────────────────────────────────────────────╯
--]]

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function sequence(from, to)
  local i = from - 1
  return function()
    if i < to then
      i = i + 1
      return i
    end
  end
end

local function range(from, to)
  local cc = {}
  for i in sequence(from, to) do table.insert(cc, i) end

  return cc
end

local function create_augroup(autocmds, name)
  cmd('augroup ' .. name)
  cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  cmd('augroup END')
end

-- Indentation
g.mapleader = ","
g.localleader = "\\"

-- backups
g.backup = false
g.writebackup = false

-- flash don't audibly beep
g.errorbells = false
g.visualbell = true

-- preview replace
g.inccommand = "nosplit"

vim.o.shortmess = vim.o.shortmess .. 'c' -- Avoid showing message extra message when using completion
vim.bo.formatoptions = vim.bo.formatoptions .. ',w' -- Tack on 'w' to format options
cmd 'retab' -- Replaces all sequences of white-space containing a <Tab> with spaces
opt('b', 'expandtab', true) -- Use spaces instead of tabs
opt('b', 'modeline', true)
opt('b', 'shiftwidth', indent) -- Size of an indent
opt('b', 'smartindent', true) -- Insert indents automatically
opt('b', 'tabstop', indent) -- Number of spaces tabs count for
opt('b', 'swapfile', false) -- Swapfile
opt('b', 'textwidth', 110) -- Match GitHub's 110 char width
opt('o', 'completeopt', 'menuone,noselect') -- Completion options (for deoplete)
opt('o', 'hidden', true) -- Enable modified buffers in background
opt('o', 'ignorecase', true) -- Ignore case
opt('o', 'joinspaces', false) -- No double spaces with join after a dot
opt('o', 'scrolloff', 4) -- Lines of context
opt('o', 'shiftround', true) -- Round indent
opt('o', 'sidescrolloff', 8) -- Columns of context
opt('o', 'smartcase', true) -- Don't ignore case with capitals
opt('o', 'splitbelow', true) -- Put new windows below current
opt('o', 'splitright', true) -- Put new windows right of current
opt('o', 'termguicolors', true) -- True color support
opt('o', 'wildmode', 'longest:full,full') -- Command-line completion mode
opt('w', 'cursorline', true) -- Highlight the screen line of the cursor with CursorLine
opt('w', 'foldmethod', 'syntax') -- The kind of folding used for the current window
opt('w', 'foldcolumn', '0') -- When and how to draw the foldcolumn
opt('w', 'foldnestmax', 8) -- Sets the maximum nesting of folds for the "indent" and "syntax" methods
opt('w', 'foldlevel', 3) -- Sets the fold level: higher levels will be closed.
opt('w', 'list', true) -- Show some invisible characters (tabs...)
opt('w', 'listchars', 'tab:»\\ ,nbsp:෴,trail:-') -- Replace tabs, &nbsp and trailing chars with visible chars
opt('w', 'number', true) -- Print line number
opt('w', 'relativenumber', true) -- Relative line numbers
opt('w', 'wrap', false) -- Disable line wrap

-- mappings
map('n', '<Leader>j', 'gT', {noremap = true})
map('n', '<Leader>k', 'gt', {noremap = true})
map('i', 'jj', '<Esc>', {noremap = true})
map('i', 'kk', '<Esc>:w<CR>', {noremap = true})
map('n', 'gx', 'yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>')
map('v', '<C-r>', [["hy:%s/<C-r>h//gc<left><left><left>]], {noremap = true})

cmd('set showcmd')

vim.wo.colorcolumn = table.concat(range(111, 999), ",")
cmd("autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black")
cmd("autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey")

-- restore cursor position
cmd([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |   exe "normal! g`\"" | endif
]])

-- easy vimrc editing
-- cmd("autocmd bufwritepost init.lua :luafile %")
cmd("autocmd bufwritepost init.lua :set nohlsearch")

create_augroup({
  {'WinEnter', '*', 'set', 'cul'}, {'WinLeave', '*', 'set', 'nocul'}
}, 'BgHighlight')

--[[
PACKAGES
--]]

local execute = vim.api.nvim_command
local install_path = fn.stdpath('data') .. '/site/pack/paqs/opt/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print('Installing paq')
  execute('!git clone https://github.com/savq/paq-nvim.git ' .. install_path)
end

vim.cmd 'packadd paq-nvim' -- Load package
require('paq-nvim') {
  -- LuaFormatter off
  {'savq/paq-nvim', opt = true},        -- Let Paq manage itself
  {
    'nvim-treesitter/nvim-treesitter',  -- parsing system
    run = ":TSUpdate"
  },
  'tpope/vim-sensible',                 -- defaults
  'tpope/vim-obsession',                -- sessions
  'tpope/vim-projectionist',            -- project config
  'kyazdani42/nvim-tree.lua',           -- file explorer
  'vimlab/split-term.vim',              -- terminal
  'sheerun/vim-polyglot',               -- programming languages
  'nvim-lua/plenary.nvim',              -- utils
  'tpope/vim-fugitive',                 -- git
  'junegunn/gv.vim',                    -- git
  'tpope/vim-rhubarb',                  -- git
  'idanarye/vim-merginal',              -- git
  'mhinz/vim-signify',                  -- gutter signs
  'sindrets/diffview.nvim',             -- git
  'TimUntersberger/neogit',             -- git
  'b3nj5m1n/kommentary',                -- comments
  'phaazon/hop.nvim',                   -- search
  {
    'iamcco/markdown-preview.nvim',     -- markdown
     run = 'cd app & yarn install'
   },
  'tpope/vim-eunuch',                   -- UNIX
  'tpope/vim-dotenv',                   -- environment variables
  'direnv/direnv.vim',                  -- environment variables
  'tpope/vim-rails',                    -- ruby
  'tpope/vim-rake',                     -- ruby
  'vim-test/vim-test',                  -- testing
  'haya14busa/is.vim',                  -- search
  'ishan9299/nvim-solarized-lua',       -- colors
  'hoob3rt/lualine.nvim',               -- status line
  'junegunn/vim-easy-align',            -- text
  'kyazdani42/nvim-web-devicons',       -- icons
  'nvim-lua/popup.nvim',                -- UI
  'nvim-telescope/telescope.nvim',      -- UI
  'gennaro-tedesco/nvim-jqx',           -- json
  'neovim/nvim-lspconfig',              -- LSP
  'hrsh7th/vim-vsnip',                  -- LSP
  'hrsh7th/vim-vsnip-integ',            -- LSP
  'hrsh7th/nvim-compe'                  -- LSP
-- LuaFormatter on
}

g["nvim_tree_ignore"] = {
  '\\~$', 'tfstate$', 'tfstate\\.backup$', '.git', 'node_modules', '.cache',
  '.direnv', '.elixir_ls', '_build', 'cover'
}

--[[
--MAPPINGS
--]]
map('n', '<leader>n', ':NvimTreeToggle<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
map('n', '<C-n>', ':NvimTreeFindFile<CR>')

-- allow terminal buffer size to be very large
g["terminal_scrollback_buffer_size"] = 100000
g["split_term_default_shell"] = "fish"

-- map esc to exit to normal mode in terminal too
create_augroup({
  {'TermOpen', '*', 'set', 'nonu'}, {'TermOpen', '*', 'set', 'norelativenumber'}
}, 'Terminal')

-- map esc to exit to normal mode in terminal too
map("t", "<Esc><Esc>", "<C-\\><C-n>", {noremap = true})
-- Jump and Create splits easily
map('n', '<Leader>fs', ':Term<CR>')
map('n', '<Leader>fv', ':VTerm<CR>')
map('n', '<Leader>ff', ':TTerm<CR>')
map('n', '<Leader>fp', ':TTerm<CR> postgres<CR>')

g["rustfmt_autosave"] = 1

-- git
g.updatetime = 100

require("neogit").setup({integrations = {diffview = true}})
map('n', '<Leader>g', ':Neogit<CR>')
map("n", "<leader>cc", "<Plug>kommentary_line_default", {noremap = false})
map("n", "<leader>c", "<Plug>kommentary_motion_default", {noremap = false})
map("v", "<leader>cc", "<Plug>kommentary_visual_default", {noremap = false})
map("n", "<leader>dvo", ":DiffViewOpen<CR>", {noremap = false})
map("n", "<leader>dvc", ":DiffViewClose<CR>", {noremap = false})

require('hop').setup({})
map('n', '<leader>h', ':HopWord<CR>')

-- https://github.com/vim-test/vim-test#cli-options
g["test#runner_commands"] = {'ExUnit', 'ElmTest'}
g["test#strategy"] = "neovim"

map("n", "<leader>t", ":TestNearest<CR>", {silent = true})
map("n", "<leader>T", ":TestFile<CR>", {silent = true})
map("n", "<leader>ta", ":TestSuite<CR>", {silent = true})
map("n", "<leader>l", ":TestLast<CR>", {silent = true})
map("n", "<leader>tv", ":TestVisit<CR>", {silent = true}) -- search

require('lualine').setup({
  options = {
    disabled_filetypes = {'toggleterm', 'terminal'},
    theme = 'solarized_dark'
  }
})

-- themes
vim.o.bg = "dark"
map('n', '<leader>1', [[<Cmd>lua Set_solarized("dark")<CR>]],
    {noremap = true, silent = true})
map('n', '<Leader>2', [[<Cmd>lua Set_solarized("light")<CR>]],
    {noremap = true, silent = true})
cmd('colorscheme solarized')

-- statusline

-- Start interactive EasyAlign in visual mode (e.g. vipga)
map('x', 'ga', '<Plug>(EasyAlign)')
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map('n', 'ga', '<Plug>(EasyAlign)')

require('telescope').setup {
  defaults = {prompt_position = "top", sorting_strategy = "ascending"}
}
map('n', '<C-p>', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]],
    {noremap = true, silent = true})
map('n', '<C-_>',
    [[<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    {noremap = true, silent = true})
map('n', '<Leader>a', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]],
    {noremap = true, silent = true})
map('n', '<Leader>A',
    [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]],
    {noremap = true, silent = true})

-- LSP
local lspconfig = require('lspconfig')

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(_, bufnr)
  local this_map = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local map_opts = {noremap = true, silent = true}

  this_map("n", "dF", [[<cmd>lua vim.lsp.buf.formatting()<CR>]], map_opts)
  this_map("n", "gd", [[<cmd>lua vim.lsp.buf.definition()<CR>]], map_opts)
  this_map("n", "gD", [[<cmd>lua vim.lsp.buf.declaration()<CR>]], map_opts)
  this_map("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]], map_opts)
  this_map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]], map_opts)
  this_map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]], map_opts)
  this_map("n", "<C-k>", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], map_opts)
  this_map("n", "<Leader>N", [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]],
           map_opts)
  this_map("n", "<Leader>P", [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]],
           map_opts)
  this_map("n", "sld",
           [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]], map_opts)
  this_map("n", "1gD", [[<cmd>lua vim.lsp.buf.type_definition()<CR>]], map_opts)

  cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])

  -- These have a different style than above because I was fiddling
  -- around and never converted them. Instead of converting them
  -- now, I'm leaving them as they are for this article because this is
  -- what I actually use, and hey, it works ¯\_(ツ)_/¯.
  cmd [[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
  cmd [[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]

  cmd [[imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  cmd [[smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  cmd [[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]
  cmd [[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]

  cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
  cmd [[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
  cmd [[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
  cmd [[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]]
  cmd [[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]]
end

require('compe').setup {
  autocomplete = true,
  debug = false,
  documentation = true,
  enabled = true,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  min_length = 1,
  preselect = 'disabled',
  source_timeout = 200,
  throttle_time = 80,

  source = {
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    path = true,
    snippets_nvim = true,
    spell = true,
    tags = true,
    treesitter = true
    -- vsnip = true
  }
}

local elixirls_binary = vim.fn.expand(
                            "~/src/elixir-ls/release/language_server.sh")
local util = require('lspconfig/util')

lspconfig.elixirls.setup({
  cmd = {elixirls_binary},
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern("app.exs", "mix.exs", ".git") or
      vim.loop.os_homedir(),
  settings = {elixirLS = {dialyzerEnabled = false, fetchDeps = false}}
})

lspconfig.efm.setup({
  capabilities = capabilities,
  filetypes = {"elixir", "html", "lua", "sh", "yaml"},
  init_options = {documentFormatting = true},
  on_attach = on_attach
})

lspconfig.denols.setup({})

local sumneko_root_path = vim.fn.expand("~/src/lua-language-server")
local sumneko_binary = vim.fn.expand(sumneko_root_path ..
                                         "/bin/Linux/lua-language-server")

lspconfig.sumneko_lua.setup({
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      diagnostics = {globals = {"vim", "describe"}},
      runtime = {version = "LuaJIT", path = vim.split(package.path, ";")}
    },
    workspace = {
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
      }
    }
  }
})

lspconfig.solargraph.setup({})

-- TODO

--[[ " Automatic setting of the executable bit
" http://vim.wikia.com/wiki/Setting_file_attributes_without_reloading_a_buffer
function! SetExecutableBit()
  let fname = expand("%:p")
  checktime
  execute "au FileChangedShell " . fname . " :echo"
  silent !chmod a+x %
  checktime
  execute "au! FileChangedShell " . fname
endfunction
command! Xbit call SetExecutableBit()
autocmd BufWritePost *.pl Xbit
autocmd BufWritePost *.bash Xbit
autocmd BufWritePost *.sh Xbit ]]

--[[ au FileType elixir nnoremap io o\|> IO.inspect(printable_limit: :infinity)<Esc>
au FileType elixir nnoremap IO o\|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i
au FileType elixir nnoremap ii a \|> IO.inspect(printable_limit: :infinity)<Esc>i
au FileType elixir nnoremap II a \|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i
au FileType elixir nnoremap <leader>r orequire IEx; IEx.pry<esc> ]]

-- au FileType ruby map <Leader>fsl gg O# frozen_string_literal: true<CR><Esc>x

-- autocmd Filetype elm setlocal ts=4 sw=4 sts=4 expandtab nowrap
