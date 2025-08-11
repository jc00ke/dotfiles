vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp" },
})

require("blink.cmp").setup({
  fuzzy = {
    implementation = "prefer_rust"
  },
})
