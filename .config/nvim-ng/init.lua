vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"

vim.opt.relativenumber = true
vim.wo.number = true

vim.opt.tabstop = 2
vim.opt.expandtab = true

vim.opt.splitright = true
vim.opt.splitbelow = true

-- https://github.com/nvim-tree/nvim-tree.lua#quick-start
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- lspconfig
-- fidget?
-- completion
-- which-key
-- telescope
-- -- fzf
-- highlight on yank
