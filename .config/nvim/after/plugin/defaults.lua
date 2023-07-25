vim.opt.relativenumber = true

vim.opt.tabstop = 2

vim.o.splitright = true
vim.o.splitbelow = true

vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--[[
  ╭────────────────────────────────────────────────────────────────────────────────────────────────────╮
  │  String value  │  Help page   │  Affected modes                           │  Vimscript equivalent  │
  │────────────────────────────────────────────────────────────────────────────────────────────────────│
  │  ''            │  mapmode-nvo │  Normal, Visual, Select, Operator-pending │  :map                  │
  │  'n'           │  mapmode-n   │  Normal                                   │  :nmap                 │
  │  'v'           │  mapmode-v   │  Visual and Select                        │  :vmap                 │
  │  's'           │  mapmode-s   │  Select                                   │  :smap                 │
  │  'x'           │  mapmode-x   │  Visual                                   │  :xmap                 │
  │  'o'           │  mapmode-o   │  Operator-pending                         │  :omap                 │
  │  '!'           │  mapmode-ic  │  Insert and Command-line                  │  :map!                 │
  │  'i'           │  mapmode-i   │  Insert                                   │  :imap                 │
  │  'l'           │  mapmode-l   │  Insert, Command-line, Lang-Arg           │  :lmap                 │
  │  'c'           │  mapmode-c   │  Command-line                             │  :cmap                 │
  │  't'           │  mapmode-t   │  Terminal                                 │  :tmap                 │
  ╰────────────────────────────────────────────────────────────────────────────────────────────────────╯
--]]
keymap("", "<Space>", "<Nop>", term_opts)
keymap("n", "<leader>j", "gT", opts)
keymap("n", "<leader>k", "gt", opts)
keymap("i", "jj", "<esc>", opts)
keymap("i", "kk", "<esc>:w<cr>", { noremap = true })
keymap("n", "gx", 'yiW:!xdg-open <cWORD><cr> <C-r>" & <cr><cr>', { noremap = true })
keymap("v", "<C-r>", [["hy:%s/<C-r>h//gc<left><left><left>]], { noremap = true })

keymap("n", "<leader>cf", [[:let @*=expand("%:p")<cr>]], { noremap = true }) -- copy file path
keymap("n", "<leader>yf", [[:let @"=expand("%:p")<cr>]], { noremap = true }) -- yank file path
keymap("n", "<leader>cl", [[:let @+=expand("%:p")<cr>]], { noremap = true }) -- copy file path to clipboard
keymap("n", "<leader>fn", [[:let @"=expand("%")<cr>]], { noremap = true })   -- yank file name
keymap("n", "<leader>cs", [[:let @+=expand("%")<cr>]], { noremap = true })   -- copy file name to clipboard

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<cr>==", opts)
keymap("v", "<A-k>", ":m .-2<cr>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<cr>gv-gv", opts)
keymap("x", "K", ":move '<-2<cr>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<cr>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<cr>gv-gv", opts)

keymap("n", "<C-p>", require('telescope.builtin').git_files, opts)
keymap("n", "<C-P>", require('telescope.builtin').find_files, opts)
keymap("n", "<C-b>", require('telescope.builtin').buffers, opts)
keymap("n", "<leader>F", require('telescope.builtin').current_buffer_fuzzy_find, opts)
keymap("n", "<C-_>", require('telescope.builtin').oldfiles, opts)

keymap("n", "<leader>gc", require('telescope.builtin').git_commits, opts)
keymap("n", "<leader>gb", require('telescope.builtin').git_branches, opts)
keymap("n", "<leader>gs", require('telescope.builtin').git_status, opts)
keymap("n", "<leader>gbc", require('telescope.builtin').git_bcommits, opts)

keymap("n", "<leader>b", [[<cmd>GitBlameToggle<cr>]], opts)

-- Y yank until the end of line
keymap("n", "Y", "y$", opts)
keymap("n", "BDA", [[<Cmd>%bd|e#<cr>]], opts)
keymap("n", "<leader>~", [[:s/\v<(.)(\w*)/\u\1\L\2/g<cr>]], opts)

vim.cmd([[au FileType elixir nnoremap !d o\|> dbg()<esc>]])

-- somewhere in your config:
vim.cmd("colorscheme onelight")
