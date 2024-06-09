require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c',
    'elixir',
    'eex',
    'go',
    'heex',
    'hurl',
    'lua',
    'python',
    'ruby',
    'rust',
    'tsx',
    'typescript',
    'vimdoc',
    'vim',
  },
  highlight = { enable = true },
  incremental_selection = { enable = false },
  indent = { enable = false },
  textobjects = { enable = false },
})

require('vim.treesitter.query').set('lua', 'injections', '')
