vim.pack.add({
  { src = "https://github.com/echasnovski/mini.sessions" },
})

local sessions_path = vim.fn.stdpath('state') .. "/sessions"
local current_dir = vim.fn.getcwd():gsub("%.", "__dot__"):gsub("/", "__"):gsub("\\", "__"):gsub(":", "")
local sessions_file = sessions_path .. "/" .. current_dir

local sessions = require('mini.sessions')

sessions.setup({
  autoread = false,
  autowrite = false,
  file = "",
  directory = sessions_path
})
vim.keymap.set("n", "<leader>ss", function()
  sessions.select()
end, { desc = "Select sessions" })

vim.keymap.set("n", "<leader>sl", function()
  if vim.fn.filereadable(sessions_file) == 1 then
    sessions.read(current_dir, { force = true })
  end
end, { desc = "Load session" })

---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd('VimLeavePre', {
  desc = 'Write session',
  group = vim.api.nvim_create_augroup("my.sessions", {}),
  callback = function()
    sessions.write(current_dir, { force = true })
  end,
})
