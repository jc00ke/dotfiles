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
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
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

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
