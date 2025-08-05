return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  },
  config = function()
    require("nvim-tree").setup({})
  end,
  keys = {
    {
      "<leader>n",
      "<cmd>NvimTreeToggle<cr>",
      noremap = true,
      silent = true,
    },
    {
      "<leader>N",
      "<cmd>NvimTreeFindFileToggle<cr>",
      noremap = true,
      silent = true,
    },
  },
}
