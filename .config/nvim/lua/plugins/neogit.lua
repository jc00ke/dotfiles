vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" }
})

require("neogit").setup({
  disable_commit_confirmation = true,
})

vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", { noremap = true, desc = "Open Neogit" })
