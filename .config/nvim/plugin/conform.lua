vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

require('conform').setup({
  -- Map of filetype to formatters
  formatters_by_ft = {
    javascript = { 'oxfmt' },
    json = { "oxfmt" },
    just = { 'just' },
    markdown = { 'rumdl' },
    ps1 = { "ps1" },
    sh = { 'shfmt' },
    sql = { 'sleek' },
    terraform = { 'terraform_fmt' },
    toml = { "oxfmt" },
    typescript = { 'oxfmt' },
    yaml = { 'oxfmt' },
  },

  -- Set up format-on-save
  format_on_save = function(bufnr)
    -- if vim.bo.filetype == "ps1" then
    --   return
    -- end
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

    return { timeout_ms = 1500, lsp_format = "fallback" }
  end,
  -- Customize formatters
  formatters = {
    ps1 = {
      command = "pwsh",
      args = {
        "-NoLogo",
        "-NoProfile",
        "-NonInteractive",
        "-Command",
        "(Invoke-Formatter ($input | Out-String)).Trim()",
      },
      stdin = true,
      condition = function(_, _)
        return vim.fn.executable("pwsh") == 1
      end,
    },
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
