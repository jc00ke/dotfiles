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

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
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
local paq = require('paq-nvim').paq -- Import module and bind `paq` function
paq {'savq/paq-nvim', opt = true} -- Let Paq manage itself
paq {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
paq 'tpope/vim-sensible'
paq 'tpope/vim-obsession'
paq 'kyazdani42/nvim-tree.lua'
map('n', '<leader>n', ':NvimTreeToggle<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
map('n', '<C-n>', ':NvimTreeFindFile<CR>')
g["nvim_tree_ignore"] = {
  '\\~$', 'tfstate$', 'tfstate\\.backup$', '.git', 'node_modules', '.cache',
  '.direnv', '.elixir_ls', '_build', 'cover'
}
-- g["nvim_tree_show_icons"] = {
-- 'git'
-- }

--[[
--TERMINAL
--]]

paq 'vimlab/split-term.vim'

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

paq 'sheerun/vim-polyglot'
g["rustfmt_autosave"] = 1

-- utils
paq 'nvim-lua/plenary.nvim'
RELOAD = require('plenary.reload').reload_module

-- sessions
paq 'tpope/vim-obsession'

-- git
paq 'tpope/vim-fugitive'
paq 'junegunn/gv.vim'
paq 'tpope/vim-rhubarb'
paq 'idanarye/vim-merginal'
paq 'mhinz/vim-signify'
g.updatetime = 100
paq 'TimUntersberger/neogit'
map('n', '<Leader>g', ':Neogit<CR>')

paq 'b3nj5m1n/kommentary'
map("n", "<leader>cc", "<Plug>kommentary_line_default", {noremap = false})
map("n", "<leader>c", "<Plug>kommentary_motion_default", {noremap = false})
map("v", "<leader>cc", "<Plug>kommentary_visual_default", {noremap = false})

paq 'phaazon/hop.nvim'
map('n', '<leader>h', ':HopWord<CR>')

paq {'iamcco/markdown-preview.nvim', run = 'cd app & yarn install'}

-- Unix
paq 'tpope/vim-eunuch'
paq 'tpope/vim-dotenv'
paq 'direnv/direnv.vim'

-- Ruby
paq 'tpope/vim-rails' -- , { 'for': 'ruby' }
paq 'tpope/vim-rake' -- , { 'for': 'ruby' }

-- Testing
paq 'vim-test/vim-test'
-- https://github.com/vim-test/vim-test#cli-options
g["test#runner_commands"] = {'ExUnit', 'ElmTest'}
g["test#strategy"] = "neovim"
-- map("t", "<C-o>", "<C-\\><C-n>")

map("n", "<leader>t", ":TestNearest<CR>", {silent = true})
map("n", "<leader>T", ":TestFile<CR>", {silent = true})
map("n", "<leader>ta", ":TestSuite<CR>", {silent = true})
map("n", "<leader>l", ":TestLast<CR>", {silent = true})
map("n", "<leader>g", ":TestVisit<CR>", {silent = true})

-- search
paq 'haya14busa/is.vim'

-- colors
-- may be replaced by treesitter
paq 'norcalli/nvim-colorizer.lua'
require('colorizer').setup()

-- themes
paq 'tjdevries/colorbuddy.vim'
paq 'marko-cerovac/material.nvim'
require('material').change_style("oceanic")
map('n', '<C-m>', [[<Cmd>lua require('material').toggle_style()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>1',
    [[<Cmd>lua require('material').change_style('lighter')<CR>]],
    {noremap = true, silent = true})
map('n', '<Leader>2',
    [[<Cmd>lua require('material').change_style('oceanic')<CR>]],
    {noremap = true, silent = true})

-- statusline
paq 'hoob3rt/lualine.nvim'
require('lualine').setup({options = {theme = 'onedark'}})

paq 'junegunn/vim-easy-align'
-- Start interactive EasyAlign in visual mode (e.g. vipga)
map('x', 'ga', '<Plug>(EasyAlign)')
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map('n', 'ga', '<Plug>(EasyAlign)')

paq 'kyazdani42/nvim-web-devicons'
paq 'nvim-lua/popup.nvim'
paq 'nvim-telescope/telescope.nvim'
-- local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {prompt_position = "top", sorting_strategy = "ascending"}
}
map('n', '<C-p>', [[<Cmd>lua require('telescope.builtin').find_files()<CR>  ]],
    {noremap = true, silent = true})
map('n', '<C-_>',
    [[<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>  ]],
    {noremap = true, silent = true})
map('n', '<Leader>a',
    [[<Cmd>lua require('telescope.builtin').live_grep()<CR>  ]],
    {noremap = true, silent = true})
map('n', '<Leader>A',
    [[<Cmd>lua require('telescope.builtin').grep_string()<CR>  ]],
    {noremap = true, silent = true})

-- JSON
paq 'gennaro-tedesco/nvim-jqx'

-- LSP
paq 'neovim/nvim-lspconfig'
local lspconfig = require('lspconfig')

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

paq 'hrsh7th/nvim-compe'

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
  this_map("n", "<Leader>N", [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], map_opts)
  this_map("n", "<Leader>P", [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], map_opts)
  this_map("n", "sld", [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]], map_opts)
  this_map("n", "1gD", [[<cmd>lua vim.lsp.buf.type_definition()<CR>]], map_opts)

  cmd([[autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)]])
  cmd([[autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)]])
  cmd([[autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)]])
  cmd([[autocmd BufWritePre *.ex lua vim.lsp.buf.formatting_sync(nil, 100)]])
  cmd([[autocmd BufWritePre *.exs lua vim.lsp.buf.formatting_sync(nil, 100)]])

  -- These have a different style than above because I was fiddling
  -- around and never converted them. Instead of converting them
  -- now, I'm leaving them as they are for this article because this is
  -- what I actually use, and hey, it works ¯\_(ツ)_/¯.
  -- cmd [[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
  -- cmd [[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]

  -- cmd [[imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  -- cmd [[smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  -- cmd [[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]
  -- cmd [[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]

  -- cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
  -- cmd [[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
  -- cmd [[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
  -- cmd [[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]]
  -- cmd [[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]]
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
    treesitter = true,
    vsnip = true
  }
}

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local path_to_elixirls = vim.fn.expand(
                             "~/src/elixir-ls/release/language_server.sh")

lspconfig.elixirls.setup({
  cmd = {path_to_elixirls},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {elixirLS = {dialyzerEnabled = false, fetchDeps = false}}
})

lspconfig.efm.setup({
  capabilities = capabilities,
  init_options = {documentFormatting = true},
  on_attach = on_attach,
  filetypes = {"elixir", "lua", "sh", "yaml"}
})

lspconfig.denols.setup({})

lspconfig.solargraph.setup({})
