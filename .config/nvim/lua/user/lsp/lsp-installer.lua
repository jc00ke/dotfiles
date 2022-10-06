local mason_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_ok then
  print("mason-lspconfig is not available!")
  return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  print("lspconfig is not available!")
  return
end

local default_opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}
local denols_opts = require("user.lsp.settings.denols")
local sumneko_lua_opts = require("user.lsp.settings.sumneko_lua")
local yamlls_opts = require("user.lsp.settings.yamlls")

local servers = {
  bashls = default_opts,
  clangd = default_opts,
  denols = vim.tbl_extend("keep", denols_opts, default_opts),
  dockerls = default_opts,
  elmls = default_opts,
  rust_analyzer = default_opts,
  solargraph = default_opts,
  sumneko_lua = vim.tbl_extend("keep", sumneko_lua_opts, default_opts),
  tailwindcss = default_opts,
  yamlls = vim.tbl_extend("keep", yamlls_opts, default_opts),
}

local ensure_installed = {}
for server, _ in pairs(servers) do
  table.insert(ensure_installed, server)
end

mason_lspconfig.setup({
  ensure_installed = ensure_installed,
})

for server, opts in pairs(servers) do
  lspconfig[server].setup(opts)
end
