local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
    end
  end,
  sources = {
    diagnostics.credo,
    diagnostics.hadolint,
    diagnostics.shellcheck,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.elm_format,
    formatting.mix,
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    formatting.rustywind,
    formatting.shellharden,
    formatting.shfmt.with({ extra_args = { "-ci", "-s", "-i", "2", "-bn" } }),
    formatting.stylua,
    formatting.trim_newlines,
    formatting.trim_whitespace,
  },
})
