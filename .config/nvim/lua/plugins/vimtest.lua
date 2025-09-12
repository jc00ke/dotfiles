vim.pack.add({
  { src = "https://github.com/vim-test/vim-test" },
})

vim.keymap.set("n", "<leader>tt", "<cmd>TestNearest<cr>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Run last test" })
vim.keymap.set("n", "<leader>T", "<cmd>TestFile<cr>", { desc = "Run all tests in the file" })
vim.keymap.set("n", "<leader>ta", "<cmd>TestSuite<cr>", { desc = "Run all tests" })
vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>",
  { desc = "Visits the test file from which you last run your tests" })

vim.g["test#strategy"] = "neovim"
vim.g["test#neovim#start_normal"] = 1
