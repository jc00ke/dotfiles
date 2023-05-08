return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup {}
  end,
  keys = {
    {
      "<leader>n",
      "<cmd>NeoTreeShowToggle<cr>",
      noremap = true,
      silent = true,
    },
    {
      "<C-n>",
      "<cmd>NeoTreeRevealToggle<cr>",
      noremap = true,
      silent = true,
    }
  }
}
