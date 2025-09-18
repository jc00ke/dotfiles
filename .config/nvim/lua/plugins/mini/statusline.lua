vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.diff" },
  { src = "https://github.com/nvim-mini/mini-git" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-mini/mini.statusline" },
})

require('mini.git').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.statusline').setup()
