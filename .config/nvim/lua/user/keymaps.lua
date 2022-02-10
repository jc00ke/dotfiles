vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

local keymap = vim.api.nvim_set_keymap
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
keymap("n", "<Leader>j", "gT", opts)
keymap("n", "<Leader>k", "gt", opts)
keymap("i", "jj", "<Esc>", opts)
keymap("i", "kk", "<Esc>:w<CR>", { noremap = true })
keymap("n", "gx", 'yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>', { noremap = true })
keymap("v", "<C-r>", [["hy:%s/<C-r>h//gc<left><left><left>]], { noremap = true })

keymap("n", "<Leader>cf", [[:let @*=expand("%:p")<CR>]], { noremap = true }) -- copy file path
keymap("n", "<Leader>yf", [[:let @"=expand("%:p")<CR>]], { noremap = true }) -- yank file path
keymap("n", "<Leader>cl", [[:let @+=expand("%:p")<CR>]], { noremap = true }) -- copy file path to clipboard
keymap("n", "<Leader>fn", [[:let @"=expand("%")<CR>]], { noremap = true }) -- yank file name
keymap("n", "<Leader>cs", [[:let @+=expand("%")<CR>]], { noremap = true }) -- copy file name to clipboard

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

keymap("n", "<C-p>", [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], opts)
keymap("n", "<C-P>", [[<cmd>lua require('telescope.builtin').find_files()<cr>]], opts)
keymap("n", "<C-b>", [[<cmd>lua require('telescope.builtin').buffers()<cr>]], opts)
keymap("n", "<leader>F", [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], opts)
keymap("n", "<C-_>", [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], opts)
keymap("n", "<leader>A", [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], opts)
keymap("n", "<leader>a", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], opts)
keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').file_browser()<CR>]], opts)
keymap("n", "<leader>cd", [[<Cmd>lua require('telescope').extensions.zoxide.list({})<CR>]], opts)
keymap(
  "n",
  "<leader>E",
  [[<Cmd>lua require('telescope.builtin').symbols({sources = {'emoji', 'gitmoji'}})<CR>]],
  opts
)
keymap("n", "<leader>gc", [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], opts)
keymap("n", "<leader>gb", [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], opts)
keymap("n", "<leader>gs", [[<cmd>lua require('telescope.builtin').git_status()<cr>]], opts)
keymap("n", "<leader>gbc", [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], opts)
keymap("n", "<leader>gi", [[<Cmd>lua require('telescope').extensions.gh.issues()<CR>]], opts)
keymap("n", "<leader>gr", [[<Cmd>lua require('telescope').extensions.gh.run()<CR>]], opts)
keymap("n", "<leader>gpr", [[<Cmd>lua require('telescope').extensions.gh.pull_request()<CR>]], opts)
keymap("n", "<leader>gg", [[<Cmd>lua require('telescope').extensions.gh.gist()<CR>]], opts)

keymap("n", "<leader>b", [[:ToggleBlameLine<CR>]], opts)

keymap("n", "<leader>n", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", opts)
keymap("n", "<C-n>", ":NvimTreeFindFile<CR>", opts)
--

-- Remap escape to leave terminal mode
keymap("t", "<Esc>", [[<c-\><c-n>]], opts)
keymap("t", "<C-o>", [[<C-\><C-n>]], opts)

-- Jump and Create splits easily
keymap("n", "<Leader>fs", ":Term<CR>", opts)
keymap("n", "<Leader>fv", ":VTerm<CR>", opts)
keymap("n", "<Leader>ff", ":TTerm<CR>", opts)
keymap("n", "<Leader>fp", ":TTerm<CR> postgres<CR>", opts)

keymap("n", "<Leader>g", ":Neogit<CR>", { noremap = true })
keymap("n", "<leader>dvo", ":DiffViewOpen<CR>", { noremap = false })
keymap("n", "<leader>dvc", ":DiffViewClose<CR>", { noremap = false })

keymap("n", "<leader>h", ":HopWord<CR>", opts)
keymap("n", "HH", ":HopWord<CR>", opts)

keymap("n", "<leader>t", ":TestNearest<CR>", opts)
keymap("n", "<leader>T", ":TestFile<CR>", opts)
keymap("n", "<leader>ta", ":TestSuite<CR>", opts)
keymap("n", "<leader>l", ":TestLast<CR>", opts)
keymap("n", "<leader>tv", ":TestVisit<CR>", opts)
--
-- Start interactive EasyAlign in visual mode (e.g. vipga)
keymap("x", "ga", "<Plug>(EasyAlign)", opts)
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
keymap("n", "ga", "<Plug>(EasyAlign)", opts)

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

keymap("n", "<F10>", "<cmd>lua ToggleMouse()<cr>", opts)

-- Y yank until the end of line
keymap("n", "Y", "y$", opts)
keymap("n", "BDA", [[<Cmd>%bd|e#<CR>]], opts)
keymap("n", "<leader>~", [[:s/\v<(.)(\w*)/\u\1\L\2/g<CR>]], opts)
