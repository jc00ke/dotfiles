-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

local number_toggle_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })
vim.api.nvim_create_autocmd("BufNew,BufEnter,FocusGained,InsertLeave,WinEnter", {
  callback = function()
    if vim.wo.nu then
      vim.wo.rnu = true
      vim.wo.cul = true
    end
  end,
  group = number_toggle_group,
  pattern = "*",
})
vim.api.nvim_create_autocmd("BufLeave,FocusLost,InsertEnter,WinLeave", {
  callback = function()
    if vim.wo.nu then
      vim.wo.rnu = true
      vim.wo.cul = true
    end
  end,
  group = number_toggle_group,
  pattern = "*",
})
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.rnu = false
    vim.opt_local.nu = false
    vim.opt_local.cul = false
  end,
  group = number_toggle_group,
  pattern = "*",
})

-- restore cursor position
vim.cmd([[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |   exe "normal! g`\"" | endif
]])

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    vim.lsp.buf.format()
  end,
  pattern = "<buffer>",
})

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

vim.cmd([[
" Automatic setting of the executable bit
" http://vim.wikia.com/wiki/Setting_file_attributes_without_reloading_a_buffer
function! SetExecutableBit()
  let fname = expand("%:p")
  checktime
  execute "au FileChangedShell " . fname . " :echo"
  silent !chmod a+x %
  checktime
  execute "au! FileChangedShell " . fname
endfunction
]])
local xbit_group = vim.api.nvim_create_augroup("Xbit", { clear = true })
vim.api.nvim_create_user_command("Xbit", "call SetExecutableBit()", {})
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "Xbit", group = xbit_group, pattern = { "*.bash", "*.sh" } }
)
