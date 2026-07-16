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
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    if client:supports_method("textDocument/completion") then
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


-- Helper function to dim a hex color string by a percentage
local function dim_hex_color(hex, percent)
  if not hex or hex == "None" then return nil end
  local r = tonumber(hex:sub(2, 3), 16)
  local g = tonumber(hex:sub(4, 5), 16)
  local b = tonumber(hex:sub(6, 7), 16)

  r = math.max(0, math.floor(r * (1 - percent)))
  g = math.max(0, math.floor(g * (1 - percent)))
  b = math.max(0, math.floor(b * (1 - percent)))

  return string.format("#%02x%02x%02x", r, g, b)
end

-- Universal hook that runs for ANY colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*", -- Matches everything
  callback = function()
    -- Fetch the global highlight data for the 'Normal' window
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    local bg_int = normal_hl.bg

    if bg_int then
      -- Convert the internal color integer into a standard Hex string
      local current_bg = string.format("#%06x", bg_int)

      -- Dim the background color by 6% (tweak this fraction as preferred)
      local dimmed_bg = dim_hex_color(current_bg, 0.06)

      -- Set the global highlight for inactive windows dynamically
      vim.api.nvim_set_hl(0, "NormalNC", {
        bg = dimmed_bg,
        fg = normal_hl.fg -- Preserve text visibility by keeping foreground identical
      })
    end
  end,
})
