vim.pack.add({
  { src = "https://github.com/AckslD/nvim-trevJ.lua" },
})

require("trevj").setup()

vim.keymap.set('n', "<leader>J", function()
  require("trevj").format_at_cursor()
end, { desc = "Splits line" })
