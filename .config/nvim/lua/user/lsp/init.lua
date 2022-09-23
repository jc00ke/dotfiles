local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

require("elixir").setup({
  cmd = { vim.fn.expand("~/src/elixir-ls/release/language_server.sh") },

  on_attach = require("user.lsp.handlers").on_attach,
})

lspconfig.sqls.setup({
  on_attach = function(client)
    client.server_capabilities.execute_command = true
    client.commands = require("sqls").commands -- Neovim 0.6+ only

    require("sqls").setup({ picker = "telescope" })
  end,
})
