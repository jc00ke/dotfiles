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
--]]

require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.lualine")
require("user.colorscheme")
require("user.hop")
require("user.telescope")
require("user.nvim-tree")
require("user.split-term")
require("user.vim-test")
require("user.treesitter")

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
