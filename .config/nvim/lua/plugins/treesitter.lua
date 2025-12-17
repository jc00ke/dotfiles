vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
})


vim.treesitter.query.add_predicate("is-mise?", function(_, _, bufnr, _)
  ---@cast bufnr integer
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local filename = vim.fn.fnamemodify(filepath, ":t")
  return string.match(filename, ".*mise.*%.toml$") ~= nil
end, { force = true, all = false })

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "elixir",
    "eex",
    "heex",
    "go",
    "javascript",
    "html",
    "python",
    "rust",
    "go",
    "toml",
    "bash",
    "kdl",
  },
  sync_install = false,
  highlight = { enable = true, disable = { "latex" } },
  indent = { enable = true, disable = { "python" } },
})

vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Handle nvim-treesitter updates',
  group = vim.api.nvim_create_augroup('my.nvim-treesitter-pack-changed-update-handler', { clear = true }),
  callback = function(event)
    if event.data.kind == 'update' then
      vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
      ---@diagnostic disable-next-line: param-type-mismatch
      local ok = pcall(vim.cmd, 'TSUpdate')
      if ok then
        vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
      else
        vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
      end
    end
  end,
})
