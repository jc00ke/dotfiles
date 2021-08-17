--[[
  Resources

  * https://github.com/mjlbach/defaults.nvim/blob/master/init.lua
  * https://alpha2phi.medium.com/neovim-init-lua-e80f4f136030
  * https://github.com/akinsho/nvim-toggleterm.lua
  * https://github.com/icyphox/dotfiles/tree/master/config/nvim
  * https://github.com/mjlbach/defaults.nvim/blob/master/init.lua
  * https://github.com/mjlbach/nix-dotfiles/blob/master/nixpkgs/configs/neovim/init.lua
  * https://github.com/nanotee/nvim-lua-guide
  * https://github.com/rockerBOO/awesome-neovim
  * https://icyphox.sh/blog/nvim-lua/
  * https://oroques.dev/notes/neovim-init/

  vim.o Get or set editor options, like |:set|. Invalid key is an error.

  ╭────────────────────────────────────────────────────────────────────────────────────────────────────╮
  │  String value  │  Help page   │  Affected modes                           │  Vimscript equivalent  │
  │────────────────────────────────────────────────────────────────────────────────────────────────────│
  │  ''            │  mapmode-nvo │  Normal, Visual, Select, Operator-pending │  :map                  │
  │  'n'           │  mapmode-n   │  Normal                                   │  :nmap                 │
  │  'v'           │  mapmode-v   │  Visual and Select                        │  :vmap                 │
  │  's'           │  mapmode-s   │  Select                                   │  :smap                 │
  │  'x'           │  mapmode-x   │  Visual                                   │  :xmap                 │
  │  'o'           │  mapmode-o   │  Operator-pending                         │  :omap                 │
  │  '!'           │  mapmode-ic  │  Insert and Command-line                  │  :map!                 │
  │  'i'           │  mapmode-i   │  Insert                                   │  :imap                 │
  │  'l'           │  mapmode-l   │  Insert, Command-line, Lang-Arg           │  :lmap                 │
  │  'c'           │  mapmode-c   │  Command-line                             │  :cmap                 │
  │  't'           │  mapmode-t   │  Terminal                                 │  :tmap                 │
  ╰────────────────────────────────────────────────────────────────────────────────────────────────────╯
--]]
local execute = vim.api.nvim_command
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local indent = 2
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

opt("b", "expandtab", true) -- Use spaces instead of tabs
opt("b", "modeline", true)
opt("b", "shiftwidth", indent) -- Size of an indent
opt("b", "smartindent", true) -- Insert indents automatically
opt("b", "tabstop", indent) -- Number of spaces tabs count for
opt("b", "swapfile", false) -- Swapfile
opt("b", "textwidth", 110) -- Match GitHub's 110 char width
-- opt('o', 'completeopt', 'menuone,noselect') -- Completion options (for deoplete)
opt("o", "hidden", true) -- Enable modified buffers in background
opt("o", "ignorecase", true) -- Ignore case
opt("o", "joinspaces", false) -- No double spaces with join after a dot
opt("o", "scrolloff", 4) -- Lines of context
opt("o", "shiftround", true) -- Round indent
opt("o", "sidescrolloff", 8) -- Columns of context
opt("o", "smartcase", true) -- Don't ignore case with capitals
opt("o", "splitbelow", true) -- Put new windows below current
opt("o", "splitright", true) -- Put new windows right of current
opt("o", "wildmode", "longest:full,full") -- Command-line completion mode
opt("w", "cursorline", true) -- Highlight the screen line of the cursor with CursorLine
opt("w", "foldmethod", "expr") -- The kind of folding used for the current window
opt("w", "foldexpr", "nvim_treesitter#foldexpr()")
opt("w", "foldcolumn", "0") -- When and how to draw the foldcolumn
opt("w", "foldnestmax", 8) -- Sets the maximum nesting of folds for the "indent" and "syntax" methods
opt("w", "foldlevel", 3) -- Sets the fold level: higher levels will be closed.
opt("w", "list", true) -- Show some invisible characters (tabs...)
opt("w", "listchars", "tab:»\\ ,nbsp:෴,trail:-") -- Replace tabs, &nbsp and trailing chars with visible chars
opt("w", "wrap", false) -- Disable line wrap

vim.o.shortmess = vim.o.shortmess .. "c" -- Avoid showing message extra message when using completion
vim.bo.formatoptions = vim.bo.formatoptions .. ",w" -- Tack on 'w' to format options

-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require("packer").use
require("packer").startup(function()
  use("wbthomason/packer.nvim") -- Package manager
  use("tpope/vim-fugitive") -- Git commands in nvim
  use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
  use("tpope/vim-commentary") -- "gc" to comment visual regions/lines
  -- use "lukas-reineke/indent-blankline.nvim"  -- indentation lines
  -- UI to select things (files, grep results, open buffers...)
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          file_sorter = require("telescope.sorters").get_fzy_sorter,
          generic_sorter = require("telescope.sorters").get_fzy_sorter,
          mappings = { i = { ["<C-u>"] = false, ["<C-d>"] = false } },
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
        },
      })
      -- Add leader shortcuts
      vim.api.nvim_set_keymap(
        "n",
        "<C-p>",
        [[<Cmd>lua require('telescope.builtin').git_files()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-P>",
        [[<cmd>lua require('telescope.builtin').find_files()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-b>",
        [[<cmd>lua require('telescope.builtin').buffers()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>F",
        [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-_>",
        [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>A",
        [[<cmd>lua require('telescope.builtin').grep_string()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>a",
        [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>o",
        [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<Leader>fb",
        [[<Cmd>lua require('telescope.builtin').file_browser()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>cd",
        [[<Cmd>lua require('telescope').extensions.zoxide.list({})<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>E",
        [[<Cmd>lua require('telescope.builtin').symbols({sources = {'emoji', 'gitmoji'}})<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gc",
        [[<cmd>lua require('telescope.builtin').git_commits()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gb",
        [[<cmd>lua require('telescope.builtin').git_branches()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gs",
        [[<cmd>lua require('telescope.builtin').git_status()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gp",
        [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gi",
        [[<Cmd>lua require('telescope').extensions.gh.issues()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gr",
        [[<Cmd>lua require('telescope').extensions.gh.run()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gpr",
        [[<Cmd>lua require('telescope').extensions.gh.pull_request()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gg",
        [[<Cmd>lua require('telescope').extensions.gh.gist()<CR>]],
        { noremap = true, silent = true }
      )
    end,
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  })
  use({
    "itchyny/lightline.vim", -- Fancier statusline
    config = function()
      vim.g.lightline = {
        colorscheme = "solarized",
        active = {
          left = {
            { "mode", "paste" },
            { "gitbranch", "readonly", "filename", "modified" },
          },
        },
        component_function = { gitbranch = "fugitive#head" },
      }
    end,
  })
  -- Add git related info in the signs columns and popups
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
  use({
    "hrsh7th/vim-vsnip", -- LSP
    config = function()
      --[[
      " Expand
      imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
      smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

      " Expand or jump
      imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
      smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

      " Jump forward or backward
      imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
      smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
      imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
      smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

      " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
      " See https://github.com/hrsh7th/vim-vsnip/pull/50
      nmap        s   <Plug>(vsnip-select-text)
      xmap        s   <Plug>(vsnip-select-text)
      nmap        S   <Plug>(vsnip-cut-text)
      xmap        S   <Plug>(vsnip-cut-text)onfig  function ()
    --]]
    end,
    requires = { "hrsh7th/vim-vsnip-integ" },
  })
  use("hrsh7th/nvim-compe") -- Autocompletion plugin
  use("tpope/vim-sensible") -- defaults
  use("tpope/vim-obsession") -- sessions
  use("tpope/vim-projectionist") -- project config
  use("tpope/vim-surround") -- text
  use("kyazdani42/nvim-tree.lua") -- file explorer
  use({
    "vimlab/split-term.vim", -- terminal
    config = function()
      -- Remap escape to leave terminal mode
      vim.api.nvim_set_keymap("t", "<Esc>", [[<c-\><c-n>]], { noremap = true })
      vim.api.nvim_set_keymap("t", "<C-o>", [[<C-\><C-n>]], { noremap = true })
      -- Jump and Create splits easily
      vim.api.nvim_set_keymap("n", "<Leader>fs", ":Term<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<Leader>fv", ":VTerm<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<Leader>ff", ":TTerm<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<Leader>fp", ":TTerm<CR> postgres<CR>", { noremap = true })
      -- allow terminal buffer size to be very large
      vim.g["terminal_scrollback_buffer_size"] = 100000
      vim.g["split_term_default_shell"] = "fish"
    end,
  })
  --  use 'sheerun/vim-polyglot'                   -- programming languages
  --  use 'mhinz/vim-signify'                      -- gutter signs
  use({
    "TimUntersberger/neogit", -- git
    config = function()
      require("neogit").setup({ integrations = { diffview = true } })
      vim.api.nvim_set_keymap("n", "<Leader>g", ":Neogit<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>dvo", ":DiffViewOpen<CR>", { noremap = false })
      vim.api.nvim_set_keymap("n", "<leader>dvc", ":DiffViewClose<CR>", { noremap = false })
    end,
    requires = { "sindrets/diffview.nvim" },
  })
  use({
    "phaazon/hop.nvim", -- search
    config = function()
      require("hop").setup({})
      vim.api.nvim_set_keymap("n", "<leader>h", ":HopWord<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "HH", ":HopWord<CR>", { noremap = true })
    end,
  })
  use("tpope/vim-eunuch") -- UNIX
  use("tpope/vim-dotenv") -- environment variables
  use("direnv/direnv.vim") -- environment variables
  use("tpope/vim-rails") -- ruby
  use("tpope/vim-rake") -- ruby
  use({
    "vim-test/vim-test",
    config = function()
      -- https://github.com/vim-test/vim-test#cli-options
      vim.g["test#runner_commands"] = { "ExUnit", "ElmTest" }
      vim.g["test#strategy"] = "neovim"

      vim.api.nvim_set_keymap("n", "<leader>t", ":TestNearest<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>T", ":TestFile<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ta", ":TestSuite<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>l", ":TestLast<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>tv", ":TestVisit<CR>", { silent = true })
    end,
  })
  use("haya14busa/is.vim") -- search
  use({
    "ishan9299/nvim-solarized-lua", -- colors
    config = function()
      vim.cmd([[colorscheme solarized]])
    end,
  })
  use({
    "junegunn/vim-easy-align",
    config = function()
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = true })
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", { noremap = true })
    end,
  })
  use("kyazdani42/nvim-web-devicons") -- icons
  use("nvim-telescope/telescope-symbols.nvim") -- UI
  use("nvim-telescope/telescope-github.nvim") -- github
  use("jvgrootveld/telescope-zoxide") -- projects
  use("gennaro-tedesco/nvim-jqx") -- json
  use("elixir-editors/vim-elixir") -- Elixir
  use({
    "iamcco/markdown-preview.nvim", -- markdown
    ft = "markdown",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter", -- parsing system
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
  })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  --use({"lukas-reineke/indent-blankline.nvim", config = function () vim.g["indent_blankline_enabled"] = false end})
  use("lambdalisue/suda.vim")
end)

-- Incremental live completion
vim.o.inccommand = "nosplit"

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Do not save when switching buffers
vim.o.hidden = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.cmd([[set undofile]])

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.o.bg = "dark"

-- Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.api.nvim_set_keymap("n", "<Leader>j", "gT", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>k", "gt", { noremap = true })
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("i", "kk", "<Esc>:w<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "gx", 'yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>', { noremap = true })
vim.api.nvim_set_keymap("v", "<C-r>", [["hy:%s/<C-r>h//gc<left><left><left>]], { noremap = true })

-- backups
vim.g.backup = false
vim.g.writebackup = false

-- flash don't audibly beep
vim.g.errorbells = false
vim.g.visualbell = true

vim.cmd("retab") -- Replaces all sequences of white-space containing a <Tab> with spaces

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Add map to enter paste mode
vim.o.pastetoggle = "<F3>"

-- Map blankline
-- vim.g.indent_blankline_buftype_exclude = {'terminal', 'nofile'}
-- vim.g.indent_blankline_char = "┊"
-- vim.g.indent_blankline_char_highlight = 'LineNr'
-- vim.g.indent_blankline_char_highlight_list = {'Function', 'Error'}
-- vim.g.indent_blankline_char_highlight_list = {'Error', 'Function'}
-- vim.g.indent_blankline_char_list = {'|', '¦', '┆', '┊'}
-- vim.g.indent_blankline_filetype_exclude = {'help', 'packer'}
-- vim.g.indent_blankline_indent_level = 3
-- vim.g.indent_blankline_use_treesitter = true
--
--[[ require("indent_blankline").setup {
    char = "│",
    show_first_indent_level = true,
    filetype_exclude = {
        "startify", "dashboard", "dotooagenda", "log", "fugitive",
        "gitcommit", "packer", "vimwiki", "markdown", "json", "txt",
        "vista", "help", "todoist", "NvimTree", "peekaboo", "git",
        "TelescopePrompt", "undotree", "flutterToolsOutline", "" -- for all buffers without a file type
    },
    buftype_exclude = {"terminal", "nofile"},
    show_trailing_blankline_indent = false,
    show_current_context = true,
    context_patterns = {
        "class", "function", "method", "block", "list_literal", "selector",
        "^if", "^table", "if_statement", "while", "for", "type", "var",
        "import"
    }
} ]]
-- because lazy load indent-blankline so need readd this autocmd
-- vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
-- vim.api.nvim_set_keymap("n", "<leader>tbl", ":IndentBlanklineToggle<cr>", { noremap = true })

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == "a" then
    --vim.cmd([[IndentBlanklineDisable]])
    vim.wo.signcolumn = "no"
    vim.o.mouse = "v"
    vim.wo.number = false
    print("Mouse disabled")
  else
    --vim.cmd([[IndentBlanklineEnable]])
    vim.wo.signcolumn = "yes"
    vim.o.mouse = "a"
    vim.wo.number = true
    print("Mouse enabled")
  end
end

vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua ToggleMouse()<cr>", { noremap = true })

-- Change preview window location
vim.g.splitbelow = true

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

vim.api.nvim_exec(
  [[
augroup numbertoggle
  autocmd!
  autocmd BufNew,BufEnter,FocusGained,InsertLeave,WinEnter  * if &nu | set rnu cul     | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave           * if &nu | set nornu nocul | endif
  autocmd TermOpen * setlocal nornu nonu nocul
augroup END
]],
  false
)

-- restore cursor position
vim.cmd([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |   exe "normal! g`\"" | endif
]])

-- Y yank until the end of line
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

local nvim_lsp = require("lspconfig")
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>e",
    "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "dF",
    [[<cmd>lua vim.lsp.buf.formatting()<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "1gD",
    [[<cmd>lua vim.lsp.buf.type_definition()<CR>]],
    { noremap = true, silent = true }
  )
  vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
end

-- Enable the following language servers

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

local servers = {
  "bashls",
  "clangd",
  "dockerls",
  "rust_analyzer",
  "pyright",
  "solargraph",
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({ capabilities = capabilities, on_attach = on_attach })
end

nvim_lsp.denols.setup({
  capabilities = capabilities,
  init_options = { enable = true, lint = true, unstable = true },
})

nvim_lsp.efm.setup({
  capabilities = capabilities,
  filetypes = { "elixir", "html", "lua", "sh", "yaml" },
  init_options = { documentFormatting = true },
  on_attach = on_attach,
})

local elixirls_binary = vim.fn.expand("~/src/elixir-ls/release/language_server.sh")
local util = require("lspconfig/util")

nvim_lsp.elixirls.setup({
  cmd = { elixirls_binary },
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern("app.exs", "mix.exs", ".git") or vim.loop.os_homedir(),
  settings = { elixirLS = { dialyzerEnabled = false, fetchDeps = false } },
})

nvim_lsp.fsautocomplete.setup({ capabilities = capabilities, on_attach = on_attach })

nvim_lsp.hls.setup({ capabilities = capabilities, on_attach = on_attach })

nvim_lsp.html.setup({
  capabilities = capabilities,
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    documentFormatting = true,
    embeddedLanguages = { css = true, javascript = true },
  },
  on_attach = on_attach,
})

local sumneko_root_path = vim.fn.expand("~/src/lua-language-server")
local sumneko_binary = vim.fn.expand(sumneko_root_path .. "/bin/Linux/lua-language-server")

nvim_lsp.sumneko_lua.setup({
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert"

-- Compe setup

require("compe").setup({
  autocomplete = true,
  debug = false,
  documentation = true,
  enabled = true,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  min_length = 1,
  preselect = "enable",
  source_timeout = 200,
  throttle_time = 80,

  source = {
    -- buffer = true,
    -- calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    path = true,
    snippets_nvim = true,
  },
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-n>")
  elseif check_back_space() then
    return t("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-p>")
  else
    return t("<S-Tab>")
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

vim.g["nvim_tree_ignore"] = {
  "\\~$",
  "tfstate$",
  "tfstate\\.backup$",
  ".git",
  "node_modules",
  ".cache",
  ".direnv",
  ".elixir_ls",
  "_build",
  "cover",
}
vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFile<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "BDA", [[<Cmd>%bd|e#<CR>]], { noremap = true })

-- TODO

--[[ " Automatic setting of the executable bit
" http://vim.wikia.com/wiki/Setting_file_attributes_without_reloading_a_buffer
function! SetExecutableBit()
  let fname = expand("%:p")
  checktime
  execute "au FileChangedShell " . fname . " :echo"
  silent !chmod a+x %
  checktime
  execute "au! FileChangedShell " . fname
endfunction
command! Xbit call SetExecutableBit()
autocmd BufWritePost *.pl Xbit
autocmd BufWritePost *.bash Xbit
autocmd BufWritePost *.sh Xbit ]]

--[[ au FileType elixir nnoremap io o\|> IO.inspect(printable_limit: :infinity)<Esc>
au FileType elixir nnoremap IO o\|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i
au FileType elixir nnoremap ii a \|> IO.inspect(printable_limit: :infinity)<Esc>i
au FileType elixir nnoremap II a \|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i
au FileType elixir nnoremap <leader>r orequire IEx; IEx.pry<esc> ]]

-- au FileType ruby map <Leader>fsl gg O# frozen_string_literal: true<CR><Esc>x

-- autocmd Filetype elm setlocal ts=4 sw=4 sts=4 expandtab nowrap
--
--[[ Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
autocmd User DBUIOpened let b:dotenv = DotenvRead('.envrc') | norm R
let g:db_ui_save_location = './exploration'
let g:completion_matching_strategy_list = ['exact', 'substring'] ]]

--[[ Plug 'kristijanhusak/vim-carbon-now-sh'
vnoremap <F5> :CarbonNowSh<CR>
let g:carbon_now_sh_options = 'bg=rgba%2838%2C139%2C210%2C1%29&ln=true&t=solarized+light&fm=Source+Code+Pro' ]]

-- vim.cmd('set showcmd')

--[[
create_augroup({
  {'WinEnter', '*', 'set', 'cul'}, {'WinLeave', '*', 'set', 'nocul'}
}, 'BgHighlight')
--]]

-- https://github.com/ayamir/nvimdots

vim.g["rustfmt_autosave"] = 1
