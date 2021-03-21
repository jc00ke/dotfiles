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

cmd 'colorscheme desert'                              -- Put your favorite colorscheme here
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
opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('w', 'cursorline', true)                          -- Highlight the screen line of the cursor with CursorLine
opt('w', 'foldmethod', 'syntax')                      -- The kind of folding used for the current window
opt('w', 'foldcolumn', '0')                             -- When and how to draw the foldcolumn
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
cmd("autocmd bufwritepost init.lua :luafile %")
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
--paq 'ap/vim-css-color'
paq 'tpope/vim-obsession'
paq 'scrooloose/nerdcommenter'
paq 'scrooloose/nerdtree'
map('', '<Leader>n', ':NERDTreeToggle<CR>')
g["NERDTreeIgnore"] = {'\\~$', 'tfstate$', 'tfstate\\.backup$'}

--[[
--TERMINAL
--]]

paq 'vimlab/split-term.vim'

-- allow terminal buffer size to be very large
g["terminal_scrollback_buffer_size"] = 100000
g["split_term_default_shell"] = "fish"

-- map esc to exit to normal mode in terminal too
create_augroup({
    { 'TermOpen', '*', 'tnoremap', '<buffer>', '<Esc>', '<c-\\><c-n>' },
    { 'TermOpen', '*', 'set', 'nonu' },
}, 'Terminal')

-- Jump and Create splits easily
map('n', '<Leader>fs', ':Term<CR>')
map('n', '<Leader>fv', ':VTerm<CR>')
map('n', '<Leader>ff', ':TTerm<CR>')
map('n', '<Leader>fp', ':TTerm<CR> postgres<CR>')
