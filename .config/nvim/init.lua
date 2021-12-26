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
require("user.autocommands")
require("user.cmp")
require("user.lsp")

local nvim_lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = function(_, bufnr)
end


-- nvim_lsp.efm.setup({
--   capabilities = capabilities,
--   filetypes = { "elixir", "lua", "sh", "yaml" },
--   init_options = { documentFormatting = true },
--   on_attach = on_attach,
-- })

local elixirls_binary = vim.fn.expand("~/src/elixir-ls/release/language_server.sh")

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
