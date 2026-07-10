vim.pack.add({
  { src = 'https://github.com/rockorager/radix.nvim' },
})
require("radix").setup({
  style = "light"
})
vim.cmd.colorscheme("radix")
