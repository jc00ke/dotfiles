vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
  keymaps = {
    ["<c-s>"] = { "actions.select", opts = { horizontal = true } },
    ["<c-v>"] = { "actions.select", opts = { vertical = true } },
    ["q"] = { "actions.close", mode = "n" },
  },
  git = {
    rm = function(path)
      return true
    end
  }
})
