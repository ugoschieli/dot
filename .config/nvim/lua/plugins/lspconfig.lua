return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    event = 'VeryLazy',
    config = function()
      local lspconfig = require 'lspconfig'
      local keymaps = require 'core.keymaps'
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
      }

      local setup_server = function(server_name)
        lspconfig[server_name].setup {
          on_attach = keymaps.on_attach,
          capabilities = capabilities,
          handlers = handlers,
        }
      end

      local servers = {
        'rust_analyzer',
        'lua_ls',
        'ts_ls',
      }

      for _, server in ipairs(servers) do
        setup_server(server)
      end
    end,
  },
}
