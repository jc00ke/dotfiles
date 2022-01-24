local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

vim.cmd([[
  augroup packer_config
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Package manager
  use("numToStr/Comment.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  })
  use("nvim-lualine/lualine.nvim")
  -- Add git related info in the signs columns and popups
  use("tveskag/nvim-blame-line")
  use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
  use("williamboman/nvim-lsp-installer") -- simple to use language server installer
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

  use("hrsh7th/nvim-cmp") -- Autocompletion plugin
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-nvim-lsp")
  use("L3MON4D3/LuaSnip") --snippet engine

  use("onsails/lspkind-nvim")

  use("tpope/vim-obsession") -- sessions
  use("tpope/vim-projectionist") -- project config
  use("tpope/vim-surround") -- text
  use({
    "kyazdani42/nvim-tree.lua", -- file explorer
    requires = "kyazdani42/nvim-web-devicons",
  })
  use("vimlab/split-term.vim")
  use({
    "TimUntersberger/neogit", -- git
    -- disable = true,
    requires = { "sindrets/diffview.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("neogit").setup({ integrations = { diffview = true } })
    end,
  })
  use("phaazon/hop.nvim")
  use("tpope/vim-eunuch") -- UNIX
  use("tpope/vim-dotenv") -- environment variables
  use("direnv/direnv.vim") -- environment variables
  use("tpope/vim-rails") -- ruby
  use("tpope/vim-rake") -- ruby
  use("vim-test/vim-test")
  use("haya14busa/is.vim") -- search
  use("ishan9299/nvim-solarized-lua")
  use("junegunn/vim-easy-align")
  use("nvim-telescope/telescope-symbols.nvim") -- UI
  use("nvim-telescope/telescope-github.nvim") -- github
  use("jvgrootveld/telescope-zoxide") -- projects
  use("gennaro-tedesco/nvim-jqx") -- json
  use("elixir-editors/vim-elixir") -- Elixir
  use({
    "iamcco/markdown-preview.nvim", -- markdown
    ft = "markdown",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter", -- parsing system
    run = ":TSUpdate",
  })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("lambdalisue/suda.vim")
  use({
    "kristijanhusak/vim-carbon-now-sh",
    config = function()
      vim.g["carbon_now_sh_options"] =
        [[bg=rgba%2838%2C139%2C210%2C1%29&ln=true&t=solarized+light&fm=Source+Code+Pro]]
      vim.api.nvim_set_keymap("v", [[<F5>]], [[:CarbonNowSh<CR>]], { noremap = true, silent = true })
    end,
  })
  use("nanotee/sqls.nvim")
  use({"stevearc/qf_helper.nvim",
  config = function ()
    require("qf_helper").setup()
  end
  })

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
