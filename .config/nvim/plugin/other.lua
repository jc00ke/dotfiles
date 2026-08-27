vim.schedule(function()
  vim.pack.add({
    "https://github.com/rgroli/other.nvim",
  })

  require("other-nvim").setup({
    mappings = {
      "elixir",
      "golang",
      "python",
      "rust",
      "zig",
    },
  })

  vim.api.nvim_create_user_command("AV", "OtherVSplit", {})
  vim.api.nvim_create_user_command("AS", "OtherSplit", {})
  vim.api.nvim_create_user_command("AT", "OtherTabNew", {})
  -- vim.keymap.set("n", "<leader>oc", "<cmd>OtherClear<CR>", { desc = 'Clear other' })

  -- Context specific bindings
  -- vim.keymap.set("n", "<leader>ot", "<cmd>Other test<CR>", { desc = "Open test file" })
  -- vim.keymap.set("n", "<leader>oc", "<cmd>Other component<CR>", { desc = "Open component file" })
  -- vim.keymap.set("n", "<leader>os", "<cmd>Other scss<CR>", { desc = "Open scss file" })
  -- vim.keymap.set("n", "<leader>oh", "<cmd>Other html<CR>", { desc = "Open html file" })
end)
