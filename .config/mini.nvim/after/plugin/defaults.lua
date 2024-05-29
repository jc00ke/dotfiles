vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.o.expandtab = true

vim.o.splitright = true
vim.o.splitbelow = true

local km = vim.keymap.set
local opts = { noremap = true, silent = true }
km("n", "<leader>j", "gT", opts)
km("n", "<leader>k", "gt", opts)
km("i", "jj", "<esc>", opts)
km("i", "kk", "<esc>:w<cr>", opts)
km("n", "<leader><tab><tab>", [[:set invlist <cr>]], opts)

