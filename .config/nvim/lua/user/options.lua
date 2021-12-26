local indent = 2
local options = {
  -- termguicolors = true,                    -- set term gui colors (most terminals support this)
  backup = false, -- creates a backup file
  breakindent = true,
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = true, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  hidden = true, -- Enable modified buffers in background
  hlsearch = false, -- highlight all matches on previous search pattern
  inccommand = "nosplit", -- incremental live completion
  incsearch = true, -- set highlight on search
  ignorecase = true, -- ignore case in search patterns
  joinspaces = false, -- No double spaces with join after a dot
  mouse = "a", -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  pastetoggle = "<F3>",
  pumheight = 10, -- pop up menu height
  relativenumber = true, -- set relative numbered lines
  scrolloff = 8, -- is one of my fav
  shiftround = true, -- Round indent
  shiftwidth = indent, -- the number of spaces inserted for each indentation
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  tabstop = indent, -- insert 2 spaces for a tab
  -- timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 250, -- faster completion (4000ms default)
  wildmode = "longest:full,full", -- Command-line completion mode
  wrap = false, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  -- Set colorscheme (order is important here)
  termguicolors = true,
  bg = "dark",
}

local buffer_options = {
  modeline = true,
  textwidth = 110, -- Match GitHub's 110 char width
}

local window_options = {
  foldmethod = "expr", -- The kind of folding used for the current window
  foldexpr = "nvim_treesitter#foldexpr()",
  foldcolumn = "0", -- When and how to draw the foldcolumn
  foldnestmax = 8, -- Sets the maximum nesting of folds for the "indent" and "syntax" methods
  foldlevel = 3, -- Sets the fold level: higher levels will be closed.
  list = true, -- Show some invisible characters (tabs...)
  listchars = "tab:»\\ ,nbsp:෴,trail:-", -- Replace tabs, &nbsp and trailing chars with visible chars
}

local global_options = {
  errorbells = false,
  visualbells = true,
}

vim.opt.shortmess:append("c")
-- vim.bo.formatoptions:append("w")

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(buffer_options) do
  vim.bo[k] = v
end

for k, v in pairs(window_options) do
  vim.wo[k] = v
end

for k, v in pairs(global_options) do
  vim.g[k] = v
end

vim.cmd([[set whichwrap+=<,>,[,],h,l]])
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
vim.cmd([[retab]]) -- Replaces all sequences of white-space containing a <Tab> with spaces
