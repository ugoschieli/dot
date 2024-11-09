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

      local setup_server = function(server_name, opts)
        opts = vim.tbl_deep_extend('error', {
          on_attach = keymaps.on_attach,
          capabilities = capabilities,
          handlers = handlers,
        }, opts)
        lspconfig[server_name].setup(opts)
      end

      local servers = {
        lua_ls = {},
        nil_ls = {},
        rust_analyzer = {},
        clangd = {
          cmd = {
            'clangd',
            '--header-insertion=never',
          },
        },
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = '/home/ugo/.npm-global/lib/node_modules/@vue/typescript-plugin',
                languages = { 'javascript', 'typescript', 'vue' },
              },
            },
          },
          filetypes = {
            'javascript',
            'typescript',
            'vue',
          },
        },
        volar = {},
        elixirls = {
          cmd = { 'elixir-ls' },
        },
        emmet_ls = {},
        eslint = {},
        tailwindcss = {},
        dockerls = {},
        gopls = {},
      }

      for server, opts in pairs(servers) do
        setup_server(server, opts)
      end
    end,
  },
}
