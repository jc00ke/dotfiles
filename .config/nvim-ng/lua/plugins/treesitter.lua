return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldenable = false
    end,
    opts = {
      modules = {},
      sync_install = false,
      context_commentstring = {
        enable = true,
        enable_autocmd = false
      },
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        "c",
        "cpp",
        "eex",
        "elixir",
        "erlang",
        "go",
        "heex",
        "hurl",
        "just",
        "lua",
        "python",
        "regex",
        "rust",
        "tsx",
        "typescript",
        "vimdoc",
        "vim",
      },
      ignore_install = {},

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = { enable = true, disable = { "latex" }, use_languagetree = true },
      indent = { enable = true, disable = { "python" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
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
        swap = {
          enable = true,
          swap_next = {
            ["<leader>pa"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>pA"] = "@parameter.inner",
          },
        },
      },
    }
  }
}
