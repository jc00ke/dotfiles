local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local sorters = require("telescope.sorters")

telescope.setup({
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
    mappings = { i = { ["<C-u>"] = false, ["<C-d>"] = false } },
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
  },
})
