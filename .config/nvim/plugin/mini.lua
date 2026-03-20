vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.diff" },
  { src = "https://github.com/nvim-mini/mini-git" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-mini/mini.statusline" },
  { src = "https://github.com/nvim-mini/mini.clue" },
  { src = "https://github.com/nvim-mini/mini.comment" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/nvim-mini/mini.extra" },
  { src = "https://github.com/nvim-mini/mini.jump2d" },
  { src = "https://github.com/nvim-mini/mini.sessions" },
})

local pick = require("mini.pick")
pick.setup()
vim.ui.select = pick.ui_select

require('mini.comment').setup()
require("mini.extra").setup()
require("mini.jump2d").setup()
require('mini.git').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.statusline').setup()

-- clue
--
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<leader>' },
    { mode = 'x', keys = '<leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<c-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<c-r>' },
    { mode = 'c', keys = '<c-r>' },

    -- Window commands
    { mode = 'n', keys = '<c-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

-- sessions
--
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
