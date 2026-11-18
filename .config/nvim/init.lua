-- inspiration and resources
-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html
-- lazy loading
-- - https://nvim-mini.org/mini.nvim/doc/mini-misc.html#minimisc.safely
-- - https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html#lazy-loading
-- https://github.com/franciscopower/.dotfiles/tree/main/nvim

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.o.completeopt = 'menuone,noselect,popup'
vim.o.cursorcolumn = false
vim.o.expandtab = true
vim.o.foldlevelstart = 99
vim.o.hlsearch = false
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.mouse = "nv"
vim.o.number = true
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.winborder = "rounded"
vim.o.wrap = false

require("config.autocmd")
require("config.terminal")
require("pack")

local map = vim.keymap.set
map('n', "<leader>o", ":update<cr> :source<CR>", { desc = "Source the current file" })
map('n', "<leader>pu", ":PackUpdate<CR>", { desc = "Updates plugins to lockfile" })
map('n', "<leader>pU", ":PackUpdate!<CR>", { desc = "Updates plugins" })
map('n', "<leader>pc", ":PackClean<CR>", { desc = "Clean plugins" })
map('n', "<leader>pl", ":PackList<CR>", { desc = "List plugins" })

map("i", "jj", "<esc>")
map("i", "kk", "<esc>:update<cr>")
map("n", "<leader>j", "gT", { desc = "Next tab" })
map("n", "<leader>k", "gt", { desc = "Previous tab" })
map("", "<space>", "<nop>", { silent = true })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

-- Runs mini.pick using sh execution wrapper without touching your global shell option
-- This addresses the E79 " cannot expand wildcards" error I started seeing on MacOS.
vim.keymap.set("n", "<C-p>", function()
  -- Check if we are on a Unix-like system (macOS or Debian)
  local is_unix = vim.fn.has("win32") == 0
  local old_shell = vim.o.shell

  -- Only override the shell on Mac/Linux to fix the Fish E79 issue
  if is_unix then
    vim.o.shell = "/bin/sh"
  end

  -- Force mini.pick to look up files using 'fd' safely
  require("mini.pick").builtin.files({ tool = "fd" })

  -- Restore the original shell if we changed it
  if is_unix then
    vim.o.shell = old_shell
  end
end, { desc = "Pick files safely via fd" })
map('n', '<leader>a', ":Pick grep_live<cr>", { desc = "Grep files" })
map("n", '<leader>"', 'ciw""<Esc>P', { desc = "Double quote word" })

function OpenCurrentDir()
  vim.ui.open(vim.fn.expand("%:p:h"))
end

map('n', "<leader>O", OpenCurrentDir, { desc = "Open the current dir" })

function GrepUnderCursor()
  local word = vim.fn.expand("<cword>")
  if word ~= "" then
    require("mini.pick").builtin.grep({ pattern = word })
  end
end

vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = true

  -- Alternatively, customize specific options
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
})
map('n', '<leader>A', GrepUnderCursor, { desc = "Grep for string under cursor" })
map('n', '<leader>R', ":Pick resume<cr>", { desc = "Resume search" })
map('n', '<leader>h', ":Pick help<cr>", { desc = "Pick help" })
map('n', '<leader>e', ":Oil<cr>", { desc = "Open Oil" })
map('n', '<leader>lf', vim.lsp.buf.format, { desc = "[l]sp [f]ormat" })
map('n', '<leader>x', '<cmd>:.lua<cr>')
map('v', '<C-r>', [["hy:%s/<C-r>h//gc<left><left><left>]], { noremap = true, desc = "Replace visually selected in file" })

map('n', '<leader>dP', ":Pick diagnostic<cr>", { desc = "Diagnostics: pick" })
map('n', '<leader>do', vim.diagnostic.open_float, { desc = "Diagnostics: open floating window" })
map('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Diagnostics: put in location list" })
map('n', '<leader>dn', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Diagnostics: next' })

vim.keymap.set('n', '<leader>dp', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Diagnostics: previous' })

map('n', '<leader>de', function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { desc = 'Diagnostics: next error' })

vim.lsp.enable('mdbook_lint')
require('vim._core.ui2').enable()

vim.api.nvim_create_user_command('R', function(opts)
  vim.cmd('new | setlocal buftype=nofile bufhidden=hide noswapfile')
  vim.cmd('r !' .. opts.args)
end, { nargs = '*', complete = 'shellcmd' })


local function create_scratch_buffer()
  -- Create an unlisted, scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  -- Prevent Neovim from asking to save changes on exit
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
  vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
  -- Open the buffer in the current window
  vim.api.nvim_set_current_buf(buf)
end

map("n", "<leader>bs", create_scratch_buffer, { desc = "Toggle Scratch Buffer" })


-- Custom function to toggle window zoom
local function toggle_zoom()
  if vim.t.zoomed then
    -- Restore the previous window layout
    vim.cmd("wincmd =")
    vim.t.zoomed = false
  else
    -- Maximize the current window
    vim.cmd("wincmd _ | wincmd |")
    vim.t.zoomed = true
  end
end

-- Bind the toggle function to a single key (e.g., F3)
map('n', '_', toggle_zoom, { desc = 'Toggle window zoom' })
