local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup({
  nvim_tree_ignore = {
    ".cache",
    ".direnv",
    ".elixir_ls",
    ".git",
    "\\~$",
    "_build",
    "cover",
    "node_modules",
    "tfstate$",
    "tfstate\\.backup$",
  },
})
