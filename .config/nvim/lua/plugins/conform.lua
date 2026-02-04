vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

require('conform').setup({
  -- Map of filetype to formatters
  formatters_by_ft = {
    javascript = { 'prettier' },
    json = { "yq_json" },
    just = { 'just' },
    markdown = { 'rumdl' },
    sh = { 'shfmt' },
    sql = { 'sleek' },
    terraform = { 'terraform_fmt' },
    typescript = { 'deno_fmt' },
    yaml = { 'yq_yaml', 'yamlfmt' },
  },

  -- Set up format-on-save
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable formatting for filetypes specified in environment variable
    local disabled_filetypes = vim.env.CONFORM_DISABLE_FORMAT_FOR_FILETYPES
    if disabled_filetypes then
      local current_filetype = vim.bo[bufnr].filetype
      for disabled_filetype in disabled_filetypes:gmatch("[^,]+") do
        if disabled_filetype:match("^%s*(.-)%s*$") == current_filetype then
          return
        end
      end
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
    yq_json = {
      command = "yq",
      args = { "-p=json", "-o=json" },
    },
    yq_yaml = {
      command = "yq",
      args = { "-p=yaml", "-o=yaml" },
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
