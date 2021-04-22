local cmd = vim.cmd   -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn     -- to call Vim functions e.g. fn.bufnr()
local g = vim.g       -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local indent = 2

--[[
    Resources

    * https://icyphox.sh/blog/nvim-lua/
    * https://oroques.dev/notes/neovim-init/
    * https://github.com/nanotee/nvim-lua-guide
    * https://alpha2phi.medium.com/neovim-init-lua-e80f4f136030
    * https://github.com/mjlbach/nix-dotfiles/blob/master/nixpkgs/configs/neovim/init.lua
    * https://github.com/akinsho/nvim-toggleterm.lua
    * https://github.com/icyphox/dotfiles/tree/master/config/nvim

    ╭─────────────────────────────────────────────────────────────────────────────────────────────────╮
    │String value │  Help page   │  Affected modes                           │  Vimscript equivalent  │
    │─────────────────────────────────────────────────────────────────────────────────────────────────│
    │''           │  mapmode-nvo │  Normal, Visual, Select, Operator-pending │  :map                  │
    │'n'          │  mapmode-n   │  Normal                                   │  :nmap                 │
    │'v'          │  mapmode-v   │  Visual and Select                        │  :vmap                 │
    │'s'          │  mapmode-s   │  Select                                   │  :smap                 │
    │'x'          │  mapmode-x   │  Visual                                   │  :xmap                 │
    │'o'          │  mapmode-o   │  Operator-pending                         │  :omap                 │
    │'!'          │  mapmode-ic  │  Insert and Command-line                  │  :map!                 │
    │'i'          │  mapmode-i   │  Insert                                   │  :imap                 │
    │'l'          │  mapmode-l   │  Insert, Command-line, Lang-Arg           │  :lmap                 │
    │'c'          │  mapmode-c   │  Command-line                             │  :cmap                 │
    │'t'          │  mapmode-t   │  Terminal                                 │  :tmap                 │
    ╰─────────────────────────────────────────────────────────────────────────────────────────────────╯

--]]

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function sequence(from, to)
  local i = from - 1
  return function()
    if i < to then
      i = i + 1
      return i
    end
  end
end

function range(from, to)
  local cc = {}
  for i in sequence(111, 999) do table.insert(cc, i) end

  return cc
end

function create_augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    cmd('augroup END')
end

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end

function _G.smart_shift_tab()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end

-- Indentation
g.mapleader = ","
g.localleader = "\\"

-- backups
g.backup = false
g.writebackup = false

-- flash don't audibly beep
g.errorbells = false
g.visualbell = true

-- preview replace
g.inccommand = "nosplit"

vim.o.shortmess = vim.o.shortmess .. 'c'   -- Avoid showing message extra message when using completion
vim.bo.formatoptions = vim.bo.formatoptions .. ',w'   -- Tack on 'w' to format options
cmd 'retab'                                           -- Replaces all sequences of white-space containing a <Tab> with spaces
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'modeline', true)                            -- 
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('b', 'swapfile', false)                           -- Swapfile
opt('b', 'textwidth', 110)                            -- Match GitHub's 110 char width
opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options (for deoplete)
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'scrolloff', 4 )                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8 )                         -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'wildmode', 'longest:full,full')             -- Command-line completion mode
opt('w', 'cursorline', true)                          -- Highlight the screen line of the cursor with CursorLine
opt('w', 'foldmethod', 'syntax')                      -- The kind of folding used for the current window
opt('w', 'foldcolumn', '0')                           -- When and how to draw the foldcolumn
opt('w', 'foldnestmax', 8)                            -- Sets the maximum nesting of folds for the "indent" and "syntax" methods
opt('w', 'foldlevel', 3)                              -- Sets the fold level: higher levels will be closed.
opt('w', 'list', true)                                -- Show some invisible characters (tabs...)
opt('w', 'listchars', 'tab:»\\ ,nbsp:෴,trail:-')      -- Replace tabs, &nbsp and trailing chars with visible chars
opt('w', 'number', true)                              -- Print line number
opt('w', 'relativenumber', true)                      -- Relative line numbers
opt('w', 'wrap', false)                               -- Disable line wrap

-- mappings
map('', '<Leader>j', 'gT')
map('', '<Leader>k', 'gt')
map('i', 'jj', '<Esc>')
map('i', 'kk', '<Esc>:w<CR>')
map('n', 'gx', 'yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>')

cmd('set showcmd')

vim.wo.colorcolumn = table.concat(range(111, 999), ",")
cmd("autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black")
cmd("autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey")

-- restore cursor position
cmd([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |   exe "normal! g`\"" | endif
]])

-- easy vimrc editing
--cmd("autocmd bufwritepost init.lua :luafile %")
cmd("autocmd bufwritepost init.lua :set nohlsearch")

create_augroup({
    { 'WinEnter', '*', 'set', 'cul' },
    { 'WinLeave', '*', 'set', 'nocul' },
}, 'BgHighlight')

--[[
PACKAGES
--]]

local install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print('Installing paq')
  execute('!git clone https://github.com/savq/paq-nvim.git '..install_path)
end

vim.cmd 'packadd paq-nvim'            -- Load package
local paq = require('paq-nvim').paq   -- Import module and bind `paq` function
paq{'savq/paq-nvim', opt=true}        -- Let Paq manage itself
paq 'tpope/vim-sensible'
paq 'tpope/vim-obsession'
paq 'kyazdani42/nvim-tree.lua'
map('n', '<leader>n', ':NvimTreeToggle<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
map('n', '<C-n>', ':NvimTreeFindFile<CR>')
g["nvim_tree_ignore"] = {
  '\\~$',
  'tfstate$',
  'tfstate\\.backup$',
  '.git',
  'node_modules',
  '.cache',
  '.direnv',
  '.elixir_ls',
  '_build',
  'cover'
}
--g["nvim_tree_show_icons"] = {
  --'git'
--}

--[[
--TERMINAL
--]]

paq 'vimlab/split-term.vim'

-- allow terminal buffer size to be very large
g["terminal_scrollback_buffer_size"] = 100000
g["split_term_default_shell"] = "fish"

-- map esc to exit to normal mode in terminal too
--[[create_augroup({
    { 'TermOpen', '*', 'tnoremap', '<buffer>', '<Esc>', '<c-\\><c-n>' },
    { 'TermOpen', '*', 'set', 'nonu' },
}, 'Terminal')
--]]

-- Jump and Create splits easily
map('n', '<Leader>fs', ':Term<CR>')
map('n', '<Leader>fv', ':VTerm<CR>')
map('n', '<Leader>ff', ':TTerm<CR>')
map('n', '<Leader>fp', ':TTerm<CR> postgres<CR>')

paq 'sheerun/vim-polyglot'
g["rustfmt_autosave"] = 1

-- utils
paq 'nvim-lua/plenary.nvim'

-- sessions
paq 'tpope/vim-obsession'

-- git
paq 'tpope/vim-fugitive'
paq 'junegunn/gv.vim'
paq 'tpope/vim-rhubarb'
paq 'idanarye/vim-merginal'
paq 'mhinz/vim-signify'
g.updatetime = 100
paq 'TimUntersberger/neogit'

g.kommentary_create_default_mappings = false
paq 'b3nj5m1n/kommentary'
map("n", "<leader>cc",  "<Plug>kommentary_line_default", {})
map("n", "<leader>c",   "<Plug>kommentary_motion_default", {})
map("v", "<leader>c",   "<Plug>kommentary_visual_default", {})

paq 'phaazon/hop.nvim'
map('n', '<leader>h', ':HopWord<CR>')

paq{'iamcco/markdown-preview.nvim', run='cd app & yarn install'}

-- Unix
paq 'tpope/vim-eunuch'
paq 'tpope/vim-dotenv'
paq 'direnv/direnv.vim'

-- Ruby
paq 'tpope/vim-rails' --, { 'for': 'ruby' }
paq 'tpope/vim-rake' --, { 'for': 'ruby' }

-- Testing
paq 'vim-test/vim-test'
-- https://github.com/vim-test/vim-test#cli-options
g["test#runner_commands"] = {'ExUnit', 'ElmTest'}

-- search
paq 'haya14busa/is.vim'

-- colors
-- may be replaced by treesitter
paq 'norcalli/nvim-colorizer.lua'
require('colorizer').setup()

-- themes
paq 'tjdevries/colorbuddy.vim'
paq 'marko-cerovac/material.nvim'
require('colorbuddy').colorscheme('material')
require('material').change_style('oceanic')
map('n', '<leader>L', [[<Cmd>lua require('material').change_style('lighter')<CR>]], { noremap = true, silent = true })
map('n', '<leader>D', [[<Cmd>lua require('material').change_style('oceanic')<CR>]], { noremap = true, silent = true })

-- statusline
paq 'hoob3rt/lualine.nvim'
require('lualine').setup({ options = { theme = 'onedark' } })

paq 'junegunn/vim-easy-align'
-- Start interactive EasyAlign in visual mode (e.g. vipga)
map('x', 'ga', '<Plug>(EasyAlign)')
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map('n', 'ga', '<Plug>(EasyAlign)')

paq 'kyazdani42/nvim-web-devicons'
paq 'nvim-lua/popup.nvim'
paq 'nvim-telescope/telescope.nvim'
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending"
  }
}
map('n', '<C-p>', [[<Cmd>lua require('telescope.builtin').find_files()<CR>  ]], { noremap = true, silent = true })
map('n', '<C-_>', [[<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>  ]], { noremap = true, silent = true })
map('n', '<Leader>a', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>  ]], { noremap = true, silent = true })
map('n', '<Leader>A', [[<Cmd>lua require('telescope.builtin').grep_string()<CR>  ]], { noremap = true, silent = true })

-- map('n', '<leader>tff', <cmd>lua require('telescope.builtin').find_files()<cr>
-- map('n', '<leader>tfg', <cmd>lua require('telescope.builtin').live_grep()<cr>
-- map('n', '<leader>tfb', <cmd>lua require('telescope.builtin').buffers()<cr>
-- map('n', '<leader>tfh', <cmd>lua require('telescope.builtin').help_tags()<cr>

-- JSON
paq 'gennaro-tedesco/nvim-jqx'

-- LSP
paq 'neovim/nvim-lspconfig'
paq 'kabouzeid/nvim-lspinstall'
require'lspinstall'.setup() -- important

local servers = require('lspinstall').installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require('lspconfig')[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

require'lspconfig'.elixirls.setup{
    -- Unix
    cmd = { "/home/jesse/src/elixir-ls/release/language_server.sh" };
}

-- completion
paq 'nvim-lua/completion-nvim'
cmd([[autocmd BufEnter * lua require'completion'.on_attach() ]])

-- LSP
paq 'neovim/nvim-lspconfig'
require'lspconfig'.elixirls.setup({
    -- Unix
    cmd = { "/home/jesse/src/elixir-ls/release/language_server.sh" },
    --on_attach=require('completion').on_attach;
})

-- Use <Tab> and <S-Tab> to navigate through popup menu
map('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
map('i', '<S-Tab>', 'v:lua.smart_shift_tab()', {expr = true, noremap = true})
