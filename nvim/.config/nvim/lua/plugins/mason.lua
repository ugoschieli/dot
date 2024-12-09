return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'zapling/mason-conform.nvim',
      'stevearc/conform.nvim',
    },
    lazy = false,
    opts = {
      servers = {
        lua_ls = {},
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
      },
    },
    config = function(_, opts)
      local lsp = require 'utils.lsp'

      local function keys(t)
        local key_t = {}
        for key, _ in pairs(t) do
          table.insert(key_t, key)
        end
        return key_t
      end

      require('mason').setup()
      require('mason-conform').setup {}
      require('mason-lspconfig').setup {
        ensure_installed = keys(opts.servers),
      }

      for server, server_opts in pairs(opts.servers) do
        lsp.setup_server(server, server_opts)
      end
    end,
  },
}
