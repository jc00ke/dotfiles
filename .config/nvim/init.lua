--[[
  Resources

  * https://github.com/LunarVim/Neovim-from-scratch
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
  * https://github.com/ayamir/nvimdots

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
require("user.comment")
