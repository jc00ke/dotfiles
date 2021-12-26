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

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Package manager
  use("tpope/vim-fugitive") -- Git commands in nvim
  use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
  use("numToStr/Comment.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  })
  use("nvim-lualine/lualine.nvim")
  -- Add git related info in the signs columns and popups
  use("tveskag/nvim-blame-line")
  use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client

  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("lukas-reineke/cmp-rg")
  use("onsails/lspkind-nvim")
  use("hrsh7th/nvim-cmp") -- Autocompletion plugin

  use("tpope/vim-sensible") -- defaults
  use("tpope/vim-obsession") -- sessions
  use("tpope/vim-projectionist") -- project config
  use("tpope/vim-surround") -- text
  use({
    "kyazdani42/nvim-tree.lua", -- file explorer
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
        nvim_tree_ignore = {
          ".cache",
          ".direnv",
          ".elixir_ls",
          ".git",
          "\\~$",
          "_build",
          "cover",
          "node_modules",
          "tfstate$",
          "tfstate\\.backup$",
        },
      })
    end,
  })
  use({
    "vimlab/split-term.vim", -- terminal
    config = function()
      -- allow terminal buffer size to be very large
      vim.g["terminal_scrollback_buffer_size"] = 100000
      vim.g["split_term_default_shell"] = "fish"
    end,
  })
  use({
    "TimUntersberger/neogit", -- git
    -- disable = true,
    requires = { "sindrets/diffview.nvim", "nvim-lua/plenary.nvim" },
  })
  use("phaazon/hop.nvim")
  use("tpope/vim-eunuch") -- UNIX
  use("tpope/vim-dotenv") -- environment variables
  use("direnv/direnv.vim") -- environment variables
  use("tpope/vim-rails") -- ruby
  use("tpope/vim-rake") -- ruby
  use({
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neovim"
    end,
  })
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
    disable = false,
    "nvim-treesitter/nvim-treesitter", -- parsing system
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = false, -- false will disable the whole extension
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
    defaults = {
      preview = {
        treesitter = false,
      },
    },
  })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("lambdalisue/suda.vim")

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
