vim.keymap.set('n', 'gp', ":silent %!prettier --stdin-filepath %<CR>", { desc = "[g]et [p]rettier" })
