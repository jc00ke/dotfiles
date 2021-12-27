local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "bashls",
  "clangd",
  "denols",
  "dockerls",
  "elixirls",
  "elmls",
  "html",
  "pyright",
  "rust_analyzer",
  "solargraph",
  "sumneko_lua",
  "yamlls",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

   if server.name == "denols" then
    local denols_opts = require("user.lsp.settings.denols")
    opts = vim.tbl_deep_extend("force", denols_opts, opts)
   end

   if server.name == "elixirls" then
    local elixirls_opts = require("user.lsp.settings.elixirls")
    opts = vim.tbl_deep_extend("force", elixirls_opts, opts)
   end

   if server.name == "html" then
    local html_opts = require("user.lsp.settings.html")
    opts = vim.tbl_deep_extend("force", html_opts, opts)
   end

   if server.name == "jsonls" then
    local jsonls_opts = require("user.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
   end

   if server.name == "sumneko_lua" then
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
   end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
