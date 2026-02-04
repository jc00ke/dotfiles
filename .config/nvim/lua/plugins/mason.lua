vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

require("mason").setup()

local ensure_installed = {
  "clangd",
  "expert",
  "gopls",
  "lua_ls",
  "ruff",
  "fish_lsp",
  "docker_language_server",
  "tailwindcss",
  "tinymist",
}

if vim.fn.has('windows') == 1 then
  ensure_installed = {
    "docker_language_server",
    "gopls",
    "lua_ls",
    "ruff",
  }
end

require("mason-lspconfig").setup({
  ensure_installed = ensure_installed
})

local registry = require("mason-registry")

local mason_pkgs = {
  "prettier",
  "rumdl",
  "sleek",
  "yamlfmt",
  "yq",
}

for _, pkg_name in ipairs(mason_pkgs) do
  local ok, pkg = pcall(registry.get_package, pkg_name)
  if ok then
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end
