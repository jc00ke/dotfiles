vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

require('conform').setup({
  -- Map of filetype to formatters
  formatters_by_ft = {
    javascript = { 'prettier' },
    just = { 'just' },
    sql = { 'sleek' },
    terraform = { { 'terraform_fmt' } },
    typescript = { 'deno_fmt' },
  },

  -- Set up format-on-save
  format_on_save = { timeout_ms = 250, lsp_format = "fallback" },
  -- Customize formatters
  formatters = {
    shfmt = {
      prepend_args = { '-i', '2' },
    },
    sleek = {
      prepend_args = { '--indent-spaces', '2', '--uppercase', 'false', }
    },
    terraform_fmt = {
      command = 'tofu',
    },
  },
})
