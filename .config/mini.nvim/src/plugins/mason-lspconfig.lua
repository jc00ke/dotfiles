local lspconfig = require('lspconfig')
require('mason').setup()
local on_attach_custom = function(client, buf_id) vim.bo[buf_id].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end

local diagnostic_opts = {
  float = { border = 'double' },
  -- Show gutter sings
  signs = {
    -- With highest priority
    priority = 9999,
    -- Only for warnings and errors
    severity = { min = 'WARN', max = 'ERROR' },
  },
  -- Show virtual text only for errors
  virtual_text = { severity = { min = 'ERROR', max = 'ERROR' } },
  -- Don't update diagnostics when typing
  update_in_insert = false,
}

vim.diagnostic.config(diagnostic_opts)

local handlers = {

  function(server_name) require('lspconfig')[server_name].setup({ on_attach = on_attach_custom }) end,

  ['elixirls'] = function()
    lspconfig.elixirls.setup({
      on_attach = on_attach_custom,
      settings = {
        dialyzerEnabled = false,
        fetchDeps = false,
        enableTestLenses = false,
        suggestSpecs = false,
      },
      -- root_dir = function(fname)
      --   return lspconfig.util.root_pattern('mix.exs', '.git', 'main.exs')(fname) or vim.loop.os_homedir()
      -- end,
    })
  end,

  ['lua_ls'] = function()
    lspconfig.lua_ls.setup({
      on_attach = function(client, bufnr)
        on_attach_custom(client, bufnr)
        -- Reduce unnecessarily long list of completion triggers for better
        -- `MiniCompletion` experience
        client.server_capabilities.completionProvider.triggerCharacters = { '.', ':' }
      end,
      handlers = {
        -- Show only one definition to be usable with `a = function()` style.
        -- Because LuaLS treats both `a` and `function()` as definitions of `a`.
        ['textDocument/definition'] = function(err, result, ctx, config)
          if type(result) == 'table' then result = { result[1] } end
          vim.lsp.handlers['textDocument/definition'](err, result, ctx, config)
        end,
      },
      root_dir = function(fname)
        return lspconfig.util.root_pattern('.git')(fname) or lspconfig.util.path.dirname(fname)
      end,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
            disable = { 'undefined-field' },
          },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })
  end,

  ['tailwindcss'] = function()
    lspconfig.tailwindcss.setup({
      on_attach = on_attach_custom,
      filetypes = { 'html', 'elixir', 'eelixir', 'heex' },
      init_options = {
        userLanguages = {
          elixir = 'html-eex',
          eelixir = 'html-eex',
          heex = 'html-eex',
        },
      },
      root_dir = function(fname)
        lspconfig.util.root_pattern(
          'tailwind.config.js',
          'tailwind.config.ts',
          'postcss.config.js',
          'postcss.config.ts',
          'package.json',
          'node_modules',
          '.git',
          'mix.exs'
        )(fname)
      end,
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              'class[:]\\s*"([^"]*)"',
            },
          },
        },
      },
    })
  end,
}

local ensure_installed = {
  'clangd',
  'elixirls',
  'tsserver',
  'terraformls',
  'denols',
  'ruby_lsp',
  'tailwindcss',
}
-- terraformls workaround, if needed
-- https://github.com/hashicorp/terraform-ls/issues/1655
-- https://github.com/neovim/nvim-lspconfig/issues/3051
-- https://github.com/neovim/nvim-lspconfig/pull/3053
-- https://github.com/neovim/nvim-lspconfig/commit/75ab4fa8c16b64ec02581ce22879b52645e35def

-- Ensure the servers above are installed
require('mason-lspconfig').setup({
  ensure_installed = ensure_installed,
  handlers = handlers,
})
