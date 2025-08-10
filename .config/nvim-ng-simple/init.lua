vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.opt.winborder = "rounded"
vim.opt.hlsearch = false
vim.cmd([[set mouse=]])
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.jump2d" },
  { src = "https://github.com/mason-org/mason.nvim" },
})

require("mason").setup()
require("mini.pick").setup()
require("mini.jump2d").setup()
require("oil").setup()
require("config.lsp")
require("plugins.treesitter")
require("plugins.adwaita")
require("plugins.neogit")
require("plugins.mini.clue")
require("plugins.mini.comment")

local map = vim.keymap.set
map('n', "<leader>o", ":update<cr> :source<CR>", { desc = "Source the current file" })
map("i", "jj", "<esc>")
map("i", "kk", "<esc>:update<cr>")
map("", "<space>", "<nop>", { silent = true })
map('n', '<c-p>', ":Pick files<cr>", { desc = "[P]ick files" })
map('n', '<leader>h', ":Pick help<cr>", { desc = "[P]ick help" })
map('n', '<leader>e', ":Oil<cr>")
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>x', '<cmd>:.lua<cr>')
-- [[ terminal keymaps ]]
map("n", "<leader>fs", [[:botright terminal <cr>i]], { desc = "Open terminal in horizontal split" })
map("n", "<leader>fv", [[:vertical terminal <cr>i]], { desc = "Open terminal in vertical split" })
map("n", "<leader>ff", [[:tab terminal <cr>i]], { desc = "Open terminal in new tab" })
map(
  "n",
  "<leader>fp",
  [[:tabnew|terminal postgres<cr>]],
  { desc = "Open terminal in new tab and run Postgres" }
)
map("t", "<esc>", [[<c-\><c-n>]])
map("t", "<c-o>", [[<c-\><c-n>]])
map('t', '', "")
map('t', '', "")
