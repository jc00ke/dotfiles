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
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/nvim-mini/mini.extra" },
  { src = "https://github.com/nvim-mini/mini.jump2d" },
})

local pick = require("mini.pick")
pick.setup()
vim.ui.select = pick.ui_select
require("mini.extra").setup()
require("mini.jump2d").setup()
require("config.autocmd")
require("config.terminal")
require("plugins.oil")
require("plugins.blink")
require("plugins.mason")
require("plugins.treesitter")
require("plugins.adwaita")
require("plugins.vimtest")
require("plugins.neogit")
require("plugins.mini.clue")
require("plugins.mini.comment")
require("plugins.mini.sessions")
require("plugins.mini.statusline")
require("plugins.surround")
require("plugins.conform")
require("plugins.trevj")
require("plugins.typst-preview")

vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = true

  -- Alternatively, customize specific options
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
})

local map = vim.keymap.set
map('n', "<leader>o", ":update<cr> :source<CR>", { desc = "Source the current file" })
map("i", "jj", "<esc>")
map("i", "kk", "<esc>:update<cr>")
map("n", "<leader>j", "gT", { desc = "Next tab" })
map("n", "<leader>k", "gt", { desc = "Previous tab" })
map("", "<space>", "<nop>", { silent = true })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map('n', '<c-p>', ":Pick files tool='fd'<cr>", { desc = "Pick files" })
map('n', '<leader>a', ":Pick grep_live<cr>", { desc = "Grep files" })

function GrepUnderCursor()
  local word = vim.fn.expand("<cword>")
  if word ~= "" then
    require("mini.pick").builtin.grep({ pattern = word })
  end
end

map('n', '<leader>A', GrepUnderCursor, { desc = "Grep for string under cursor" })
map('n', '<leader>R', ":Pick resume<cr>", { desc = "Resume search" })
map('n', '<leader>h', ":Pick help<cr>", { desc = "Pick help" })
map('n', '<leader>d', ":Pick diagnostic<cr>", { desc = "Pick diagnostics" })
map('n', '<leader>e', ":Oil<cr>", { desc = "Open Oil" })
map('n', '<leader>lf', vim.lsp.buf.format, { desc = "[l]sp [f]ormat" })
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
map('v', '<C-r>', [["hy:%s/<C-r>h//gc<left><left><left>]], { noremap = true, desc = "Replace visually selected in file" })

vim.lsp.enable('mdbook_lint')
