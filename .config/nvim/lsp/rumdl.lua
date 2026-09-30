return {
  cmd = { "rumdl", "server" },
  filetypes = { "markdown" },
  -- Defer to mdbook_lint inside mdbook projects: not calling on_dir skips startup.
  root_dir = function(bufnr, on_dir)
    if vim.fs.root(bufnr, "book.toml") then
      return
    end
    on_dir(vim.fs.root(bufnr, { ".git", ".rumdl.toml" }))
  end,
  settings = {
    rumdl = {
      lineLength = 110,
    }
  }
}
