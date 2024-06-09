require('conform').setup({
  -- Map of filetype to formatters
  formatters_by_ft = {
    javascript = { { 'deno_fmt', 'prettierd', 'prettier' } },
    just = { 'just' },
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    sql = { 'sqlfluff' },
    terraform = { { 'terraform_fmt' } },
    typescript = { { 'deno_fmt' } },
  },

  -- Set up format-on-save
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
  -- Customize formatters
  formatters = {
    shfmt = {
      prepend_args = { '-i', '2' },
    },
    terraform_fmt = {
      command = 'tofu',
    },
  },
})
