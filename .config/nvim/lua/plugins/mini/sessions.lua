vim.pack.add({
  { src = "https://github.com/echasnovski/mini.sessions" },
})

local current_dir = vim.fn.getcwd():gsub("%.", "__dot__"):gsub("/", "__"):gsub("\\\\", "__")

require('mini.sessions').setup({
  autoread = true,
  autowrite = false,
  file = "",
  directory = vim.fn.stdpath('state') .. "/sessions"
})


local make_session = function()
  require("mini.sessions").write(current_dir, { force = true })
end
vim.api.nvim_create_autocmd('VimLeavePre', { callback = make_session, desc = 'Make session' })
