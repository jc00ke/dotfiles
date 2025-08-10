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

local map = vim.keymap.set
map('n', "<leader>o", ":update<cr> :source<CR>")
map("i", "jj", "<esc>")
map("i", "kk", "<esc>:update<cr>")
map("", "<space>", "<nop>", { silent = true })
map('n', '<c-p>', ":Pick files<CR>")
map('n', '<leader>h', ":Pick help<CR>")
map('n', '<leader>e', ":Oil<CR>")
map('t', '', "")
map('t', '', "")
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>x', '<cmd>:.lua<cr>')

