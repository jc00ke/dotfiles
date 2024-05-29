-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local km = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Safely execute immediately
now(function()
  vim.o.termguicolors = true
  vim.cmd('colorscheme minischeme')
end)
now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)
now(function() require('mini.tabline').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.completion').setup() end)
now(function() require('mini.sessions').setup({ autoread = true }) end)

-- Safely execute later
later(function() require('mini.ai').setup() end)
later(function() require('mini.clue').setup() end)
later(function() require('mini.comment').setup() end)
later(function()
  local MiniJump = require('mini.jump2d')
  MiniJump.setup({ mappings = { start_jumping = "HH"  } })
end)
later(function()
        local MiniPick = require('mini.pick')
        MiniPick.setup({ mappings = {} })
        km("n", "<c-p>", function() MiniPick.builtin.files({ tools = "git" }) end)
        km("n", "<c-b>", MiniPick.builtin.buffers)
end)
later(function() require('mini.surround').setup() end)

-- Use external plugins with `add()`
now(function()
  -- Add to current session (install if absent)
  add('nvim-tree/nvim-web-devicons')
  require('nvim-web-devicons').setup()
end)

now(function()
  -- Supply dependencies near target plugin
  add({ source = 'neovim/nvim-lspconfig', depends = { 'williamboman/mason.nvim' } })
end)

later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'vimdoc' },
    highlight = { enable = true },
  })
end)

-- CURRENT 			| MINI.NVIM	| Installed	| Configured?
-- --------------------------------------------------------------------------
-- carbon-now.nvim 		| 		|		|
-- cmp				| completion	| y		|
-- comment.nvim			| comment	| y		|
-- conform			|
-- diffview			|
-- elixir-tools			|
-- fidget			|
-- git-blame			|
-- gitsigns			|
-- hop				| jump		| y		| y
-- indent-blankline		|
-- lualine			|
-- LuaSnip			|
-- mason-lspconfig		|
-- neodev			|
-- neogit			|
-- nvim-solarized-lua		|
-- nvim-tree			|
-- nvim-treesitter-textobjects	|
-- persisted.nvim		|
-- plenary			| misc
-- splitjoin			|
-- telescope			| pick		| y		| n
-- treesj			|
-- trouble			|
-- vim-just			|
-- vim-projectionist		|
-- vim-rhubarb			|
-- vim-test			|
-- vim-sleuth			|
-- which-key			| clue		| y		| y

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
