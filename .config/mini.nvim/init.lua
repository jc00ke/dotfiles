pcall(function() vim.loader.enable() end)

-- Define main config table
_G.Config = {
  path_package = vim.fn.stdpath('data') .. '/site/',
  path_source = vim.fn.stdpath('config') .. '/src/',
}

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local mini_path = Config.path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = Config.path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local km = vim.keymap.set
local source = function(path) dofile(Config.path_source .. path) end
local opts = { noremap = true, silent = true }

-- Safely execute immediately
now(function()
  add('ishan9299/nvim-solarized-lua')
  vim.o.termguicolors = true
  vim.cmd('colorscheme minischeme')
end)
now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)
now(function() require('mini.sessions').setup({ autoread = true }) end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.tabline').setup() end)

-- Safely execute later
later(function() require('mini.extra').setup() end)
later(function()
  require('mini.completion').setup({
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = function(items, base)
        -- Don't show 'Text' and 'Snippet' suggestions
        items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
        return MiniCompletion.default_process_items(items, base)
      end,
    },
    window = {
      info = { border = 'double' },
      signature = { border = 'double' },
    },
  })
end)
later(function() require('mini.ai').setup() end)
later(function() require('mini.clue').setup() end)
later(function() require('mini.comment').setup() end)
later(
  function()
    require('mini.splitjoin').setup({ mappings = {
      toggle = 'J',
      split = 'JS',
      join = 'JJ',
    } })
  end
)
later(function()
  local MiniJump = require('mini.jump2d')
  MiniJump.setup({ mappings = { start_jumping = 'HH' }, view = { dim = true } })
end)
later(function()
  local MiniPick = require('mini.pick')
  MiniPick.setup()
  km('n', '<c-p>', function() MiniPick.builtin.files({ tools = 'git' }) end)
  km('n', '<c-b>', MiniPick.builtin.buffers)
  km('n', '<leader>a', MiniPick.builtin.grep_live)
end)
later(function() require('mini.surround').setup() end)
later(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

later(function() require('mini.trailspace').setup() end)

-- Use external plugins with `add()`
now(function()
  -- Add to current session (install if absent)
  add('nvim-tree/nvim-web-devicons')
  require('nvim-web-devicons').setup()
end)

now(function()
  -- Supply dependencies near target plugin
  add({
    source = 'neovim/nvim-lspconfig',
    depends = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
  })
end)

later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = {
      post_checkout = function() vim.cmd('TSUpdate') end,
    },
  })
  source('plugins/nvim-treesitter.lua')
end)

later(function()
  add({
    source = 'NeogitOrg/neogit',
    depends = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'ibhagwan/fzf-lua' },
  })
  source('plugins/neogit.lua')
  km('n', '<leader>g', '<cmd>Neogit<cr>', { noremap = true, desc = 'Open Neogit' })
  km('n', '<leader>dvo', '<cmd>DiffViewOpen<cr>', { noremap = false, desc = 'Open DiffView' })
  km('n', '<leader>dvc', '<cmd>DiffViewClose<cr>', { noremap = false, desc = 'Close DiffView' })
end)

later(function()
  add('f-person/git-blame.nvim')
  require('gitblame').setup({
    enabled = false,
  })
end)

later(function() end)

-- Formatting
later(function()
  add('stevearc/conform.nvim')
  source('plugins/conform.lua')
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  km('n', '<leader>f', function() require('conform').format({ async = true, lsp_fallback = true }) end)
end)

-- Language server configurations
later(function()
  add({
    source = 'williamboman/mason.nvim',
    depends = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'elixir-tools/elixir-tools.nvim',
    },
  })
  source('plugins/mason-lspconfig.lua')
end)

later(function()
  add('vim-test/vim-test')
  vim.cmd([[let test#strategy = 'neovim']])
  vim.cmd([[let test#neovim#start_normal = 1]])

  km('n', '<leader>t', '<cmd>TestNearest<cr>')
  km('n', '<leader>l', '<cmd>TestLast<cr>')
  km('n', '<leader>T', '<cmd>TestFile<cr>')
  km('n', '<leader>ta', '<cmd>TestSuite<cr>')
  km('n', '<leader>tv', '<cmd>TestVisit<cr>')
end)

later(function() add('cameron-wags/rainbow_csv.nvim') end)

-- CURRENT 			| MINI.NVIM	| Installed	| Configured?
-- --------------------------------------------------------------------------
-- conform			|
-- diffview			|
-- fidget			|
-- git-blame			|
-- gitsigns			|
-- indent-blankline		|
-- neodev			|
-- neogit			|
-- nvim-tree			|
-- nvim-treesitter-textobjects	|
-- telescope			| pick		| y		| n
-- trouble			|
-- vim-just			|
-- vim-projectionist		|
-- vim-rhubarb			|
-- vim-test			|
-- vim-sleuth			|

vim.g.mapleader = ','
vim.g.maplocalleader = '\\'
