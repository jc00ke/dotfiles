return {
  cmd = { 'mdbook-lint', 'lsp' },
  filetypes = { 'markdown' },
  -- Only start inside mdbook projects (root_markers alone would still start without a root).
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, 'book.toml')
    if root then
      on_dir(root)
    end
  end,
}
