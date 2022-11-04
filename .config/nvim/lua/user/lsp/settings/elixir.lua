return {
  cmd = vim.fn.expand("~/src/elixir-ls/release/language_server.sh"),

  on_attach = require("user.lsp.handlers").on_attach,
}
