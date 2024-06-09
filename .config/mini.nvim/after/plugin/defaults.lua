vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.o.expandtab = true

vim.o.splitright = true
vim.o.splitbelow = true

local km = function(mode, keys, cmd, opts)
  opts = opts or {}
  if opts.silent == nil then opts.silent = true end
  vim.keymap.set(mode, keys, cmd, opts)
end
km('', '<Space>', '<Nop>')
km('n', '<leader>j', 'gT')
km('n', '<leader>k', 'gt')
km('i', 'jj', '<esc>')
km('i', 'kk', '<esc>:w<cr>')
km('n', '<leader><tab><tab>', [[:set invlist <cr>]])

-- [[ terminal keymaps ]]
km('n', '<leader>fs', [[:botright terminal <cr>i]], { desc = 'Open terminal in horizontal split' })
km('n', '<leader>fv', [[:vertical terminal <cr>i]], { desc = 'Open terminal in vertical split' })
km('n', '<leader>ff', [[:tab terminal <cr>i]], { desc = 'Open terminal in new tab' })
km('n', '<leader>fp', [[:tabnew|terminal postgres<cr>]], { desc = 'Open terminal in new tab and run Postgres' })
km('t', '<esc>', [[<c-\><c-n>]])
km('t', '<c-o>', [[<c-\><c-n>]])
--
-- Stop highlighting of search results. NOTE: this can be done with default
-- `<C-l>` but this solution deliberately uses `:` instead of `<Cmd>` to go
-- into Command mode and back which updates 'mini.map'.
km('n', [[\h]], ':let v:hlsearch = 1 - v:hlsearch<CR>', { desc = 'Toggle hlsearch' })

km('n', 'Y', 'y$')
km('n', 'BDA', [[<cmd>%bd|e#|bd#<cr>]])
km('n', '<leader>~', [[:s/\v<(.)(\w*)/\u\1\L\2/g<cr>]])

km('n', '<leader>o', [[o<Esc>0"_D]])
km('n', '<leader>O', [[O<Esc>0"_D]])

-- Toggle list for tab chars
km('n', '<leader><tab><tab>', [[:set invlist <cr>]])
