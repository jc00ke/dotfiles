-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

vim.cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufNew,BufEnter,FocusGained,InsertLeave,WinEnter  * if &nu | set rnu cul     | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave           * if &nu | set nornu nocul | endif
  autocmd TermOpen * setlocal nornu nonu nocul
augroup END
]])

-- restore cursor position
vim.cmd([[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |   exe "normal! g`\"" | endif
]])


-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[
  command! Format execute 'lua vim.lsp.buf.formatting()'
]])
vim.cmd([[
  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
]])

vim.cmd([[
  au FileType elixir nnoremap io o\|> IO.inspect(printable_limit: :infinity)<Esc>
]])
vim.cmd([[
  au FileType elixir nnoremap IO o\|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i
]])
vim.cmd([[
  au FileType elixir nnoremap ii a \|> IO.inspect(printable_limit: :infinity)<Esc>i
]])
vim.cmd([[
  au FileType elixir nnoremap II a \|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i
]])
vim.cmd([[
  au FileType elixir nnoremap <leader>r orequire IEx; IEx.pry<esc>
]])
