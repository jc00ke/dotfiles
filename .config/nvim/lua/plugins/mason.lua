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
    "tailwindcss"
  }
})

local registry = require("mason-registry")

for _, pkg_name in ipairs { "prettier" } do
  local ok, pkg = pcall(registry.get_package, pkg_name)
  if ok then
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end
