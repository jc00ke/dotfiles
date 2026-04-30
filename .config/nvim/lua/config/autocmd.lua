-- autocmd
--------------------------------------------------------------------------------
-- Highlight when yanking
---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('my.highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- autocmd
--------------------------------------------------------------------------------
-- Custom LSP attach function
---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    if client:supports_method("textDocument/completion") then
      vim.cmd [[set completeopt+=menuone,noselect,popup]]
      -- Enable native LSP completion for this client + buffer
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true, -- auto-show menu as you type (recommended)
        -- You can also set { autotrigger = false } and trigger manually with <C-x><C-o>
      })
    end
  end,
})

-- autocmd
--------------------------------------------------------------------------------
-- Custom function to toggle auto refresh of buffer after file changes
---@diagnostic disable-next-line: param-type-mismatch
vim.g.auto_refresh_enabled = false

-- Function to toggle the behavior
function ToggleAutoRefresh()
  if vim.g.auto_refresh_enabled then
    vim.api.nvim_clear_autocmds({ group = "AutoRefresh" })
    vim.g.auto_refresh_enabled = false
    print("Auto refresh disabled")
  else
    vim.o.autoread = true
    vim.api.nvim_create_augroup("AutoRefresh", { clear = true })
    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
      group = "AutoRefresh",
      command = "if mode() != 'c' | checktime | endif",
      pattern = "*",
    })
    vim.g.auto_refresh_enabled = true
    print("Auto refresh enabled")
  end
end

vim.keymap.set('n', '<leader>tar', ToggleAutoRefresh, {
  noremap = true,
  silent = false,
  desc = "Toggle auto refresh of files"
})
