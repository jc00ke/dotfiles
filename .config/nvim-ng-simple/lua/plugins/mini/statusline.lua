vim.pack.add({
  { src = "https://github.com/echasnovski/mini.diff" },
  { src = "https://github.com/echasnovski/mini-git" },
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/echasnovski/mini.statusline" },
})

require('mini.git').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.statusline').setup()
