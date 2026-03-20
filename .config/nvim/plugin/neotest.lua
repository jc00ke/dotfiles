vim.pack.add({
  { src = "https://github.com/nvim-neotest/neotest", },
  { src = "https://github.com/nvim-neotest/nvim-nio", },
  { src = "https://github.com/nvim-lua/plenary.nvim", },
  { src = "https://github.com/antoinemadec/FixCursorHold.nvim", },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/fredrikaverpil/neotest-golang" },
})

local neotest_golang_opts = {}
require("neotest").setup({
  adapters = {
    require("neotest-golang")(neotest_golang_opts),
  },
})

local neotest = require("neotest")

local map = vim.keymap.set
map('n', '<leader>t', function()
  neotest.run.run()
end, { desc = "Run nearest test", nowait = true })

map('n', '<leader>T', function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run all tests in file" })

map('n', '<leader>ta', function()
  neotest.run.run({ suite = true })
  neotest.summary.open()
end, { desc = "Run entire suite of tests" })

map('n', '<leader>ts', function()
  neotest.summary.toggle()
end, { desc = "Toggle test summary" })

map('n', '<leader>to', function()
  neotest.output.open()
end, { desc = "Open test output" })

map('n', '<leader>tp', function()
  neotest.output_panel.toggle()
end, { desc = "Toggle test panel" })

map('n', '<leader>tq', function()
  neotest.summary.close()
end, { desc = "Close test panel" })
