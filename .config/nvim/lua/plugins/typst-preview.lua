vim.pack.add({
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
})

require("typst-preview").setup({
  dependencies_bin = { ['tinymist'] = 'tinymist' }
})
