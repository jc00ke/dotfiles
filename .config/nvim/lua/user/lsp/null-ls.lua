local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local null_helpers = require("null-ls.helpers")

local cfn_lint = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "yaml" },
  generator = null_helpers.generator_factory({
    command = "cfn-lint",
    to_stdin = true,
    to_stderr = true,
    args = { "--format", "parseable", "-" },
    format = "line",
    check_exit_code = function(code)
      return code == 0 or code == 255 or code == 4
    end,
    on_output = function(line, params)
      local row, col, end_row, end_col, code, message = line:match(":(%d+):(%d+):(%d+):(%d+):(.*):(.*)")
      local severity = null_helpers.diagnostics.severities["error"]

      if message == nil then
        return nil
      end

      if vim.startswith(code, "E") then
        severity = null_helpers.diagnostics.severities["error"]
      elseif vim.startswith(code, "W") then
        severity = null_helpers.diagnostics.severities["warning"]
      else
        severity = null_helpers.diagnostics.severities["information"]
      end

      return {
        message = message,
        code = code,
        row = row,
        col = col,
        end_col = end_col,
        end_row = end_row,
        severity = severity,
        source = "cfn-lint",
      }
    end,
  }),
}

null_ls.setup({
  debug = false,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
    end
  end,
  sources = {
    cfn_lint,
    diagnostics.credo,
    diagnostics.hadolint,
    diagnostics.shellcheck,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.deno_fmt,
    formatting.elm_format,
    formatting.json_tool,
    formatting.mix,
    formatting.prettier.with({
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    }),
    formatting.rustywind,
    formatting.shellharden,
    formatting.shfmt.with({ extra_args = { "-ci", "-s", "-i", "2", "-bn" } }),
    formatting.stylua,
    formatting.trim_newlines,
    formatting.trim_whitespace,
  },
})
