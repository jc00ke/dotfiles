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

require("user.options")

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
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })
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
  use({
    "tveskag/nvim-blame-line",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>b", [[:ToggleBlameLine<CR>]], { noremap = true, silent = true })
    end,
  })
  use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client

  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("lukas-reineke/cmp-rg")
  use("onsails/lspkind-nvim")
  use("hrsh7th/nvim-cmp") -- Autocompletion plugin

  use("tpope/vim-sensible") -- defaults
  use("tpope/vim-obsession") -- sessions
  use("tpope/vim-projectionist") -- project config
  use("tpope/vim-surround") -- text
  use({
    "kyazdani42/nvim-tree.lua", -- file explorer
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
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
      vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeToggle<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFile<CR>", { noremap = true })
    end,
  })
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
    -- disable = true,
    config = function()
      vim.api.nvim_set_keymap("n", "<Leader>g", ":Neogit<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>dvo", ":DiffViewOpen<CR>", { noremap = false })
      vim.api.nvim_set_keymap("n", "<leader>dvc", ":DiffViewClose<CR>", { noremap = false })
    end,
    requires = { "sindrets/diffview.nvim", "nvim-lua/plenary.nvim" },
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
    disable = false,
    "nvim-treesitter/nvim-treesitter", -- parsing system
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = false, -- false will disable the whole extension
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
    defaults = {
      preview = {
        treesitter = false,
      },
    },
  })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("JoosepAlviste/nvim-ts-context-commentstring")
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

vim.api.nvim_set_keymap("n", "<Leader>cf", [[:let @*=expand("%:p")<CR>]], { noremap = true }) -- copy file path
vim.api.nvim_set_keymap("n", "<Leader>yf", [[:let @"=expand("%:p")<CR>]], { noremap = true }) -- yank file path
vim.api.nvim_set_keymap("n", "<Leader>cl", [[:let @+=expand("%:p")<CR>]], { noremap = true }) -- copy file path to clipboard
vim.api.nvim_set_keymap("n", "<Leader>fn", [[:let @"=expand("%")<CR>]], { noremap = true }) -- yank file name
vim.api.nvim_set_keymap("n", "<Leader>cs", [[:let @+=expand("%")<CR>]], { noremap = true }) -- copy file name to clipboard

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local map_opts = { noremap = true, silent = true }

  map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)
  map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", map_opts)
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", map_opts)
  map("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", map_opts)
  map("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", map_opts)
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", map_opts)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", map_opts)
  map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", map_opts)
  map("n", "dF", [[<cmd>lua vim.lsp.buf.formatting()<CR>]], map_opts)
  map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", map_opts)
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", map_opts)
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", map_opts)
  vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])

  -- tell nvim-cmp about our desired capabilities
  require("cmp_nvim_lsp").update_capabilities(capabilities)
end

-- Enable the following language servers

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
  filetypes = { "elixir", "lua", "sh", "yaml" },
  init_options = { documentFormatting = true },
  on_attach = on_attach,
})

local elixirls_binary = vim.fn.expand("~/src/elixir-ls/release/language_server.sh")
-- local util = require("lspconfig/util")

nvim_lsp.elixirls.setup({
  cmd = { elixirls_binary },
  capabilities = capabilities,
  on_attach = on_attach,
  -- root_dir = util.root_pattern("app.exs", "mix.exs", ".git") or vim.loop.os_homedir(),
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
})

nvim_lsp.fsautocomplete.setup({ capabilities = capabilities, on_attach = on_attach })

nvim_lsp.hls.setup({ capabilities = capabilities, on_attach = on_attach })

nvim_lsp.html.setup({
  capabilities = capabilities,
  filetypes = { "html" },
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

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      -- for vsnip user
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "spell", keyword_length = 5 },
    { name = "rg", keyword_length = 5 },
    { name = "path" },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        spell = "[Spell]",
        path = "[Path]",
        rg = "[Rg]",
      },
    }),
  },
})

vim.api.nvim_set_keymap("n", "BDA", [[<Cmd>%bd|e#<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>~", [[:s/\v<(.)(\w*)/\u\1\L\2/g<CR>]], { noremap = true })

require("neogit").setup({ integrations = { diffview = true } })
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

vim.cmd([[au FileType elixir nnoremap io o\|> IO.inspect(printable_limit: :infinity)<Esc>]])
vim.cmd(
  [[au FileType elixir nnoremap IO o\|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i]]
)
vim.cmd([[au FileType elixir nnoremap ii a \|> IO.inspect(printable_limit: :infinity)<Esc>i]])
vim.cmd(
  [[au FileType elixir nnoremap II a \|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i]]
)
vim.cmd([[au FileType elixir nnoremap <leader>r orequire IEx; IEx.pry<esc>]])

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
vim.g["shada"] = "'20,<50,s10"
