local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.keymap.set("n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
  vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.keymap.set("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  vim.keymap.set("n", "g0", ":DocumentSymbols<cr>", opts)
  vim.keymap.set("n", "gW", ":WorkspaceSymbols<cr>", opts)
  vim.keymap.set("n", "<leader>d", ":Diagnostics<cr>", opts)
  vim.keymap.set("n", "<space>r", vim.lsp.codelens.run, opts)
  -- Elixir-specific
  -- remove the pipe operator
  vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", opts)
  -- add the pipe operator
  vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", opts)
  vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", opts)
  vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

return M
