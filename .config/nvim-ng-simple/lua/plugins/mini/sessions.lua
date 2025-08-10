vim.pack.add({
  { src = "https://github.com/echasnovski/mini.sessions" },
})

require('mini.sessions').setup({
  autoread = true,
  directory = "mini-sessions"
})
