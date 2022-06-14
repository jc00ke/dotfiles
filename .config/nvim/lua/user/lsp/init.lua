local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

local elixirls_opts = require("user.lsp.settings.elixirls")
lspconfig.elixirls.setup(elixirls_opts)

lspconfig.sqls.setup({
  on_attach = function(client)
    client.server_capabilities.execute_command = true
    client.commands = require("sqls").commands -- Neovim 0.6+ only

    require("sqls").setup({ picker = "telescope" })
  end,
})
