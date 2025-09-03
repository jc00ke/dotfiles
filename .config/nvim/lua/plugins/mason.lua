vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "expert",
    "gopls",
    "lua_ls",
    "ruff",
    "fish_lsp",
    "docker_language_server",
    "prettier"
  }
})
