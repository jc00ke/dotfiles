local version = "v1.6.0"
vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp", version = version },
})

require("blink.cmp").setup({
  fuzzy = {
    implementation = "prefer_rust"
  },
  prebuilt_binaries = {
    force_version = version
  }
})
