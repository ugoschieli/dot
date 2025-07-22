return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'zapling/mason-conform.nvim',
      'stevearc/conform.nvim',
    },
    lazy = false,
    config = function(_, _)
      local lsp = require 'utils.lsp'
      local utils = require 'utils'

      local opts = {
        servers = {
          lua_ls = {},
          ts_ls = {},
          eslint = {},
          emmet_language_server = {},
          tailwindcss = {},
          dockerls = {},
          gopls = {},
          arduino_language_server = {},
          cssls = {},
          html = {},
          clangd = {},
        },
      }

      local local_servers = {
        servers = {
          rust_analyzer = {},
          -- clangd = {
          --   cmd = {
          --     'clangd',
          --     '--header-insertion=never',
          --   },
          -- },
          hls = {
            filetypes = { 'haskell', 'lhaskell', 'cabal' },
          },
        },
      }

      local local_formatters = {
        'clang-format',
      }

      require('mason').setup()
      require('mason-conform').setup {
        ignore_install = local_formatters,
      }
      require('mason-lspconfig').setup {
        ensure_installed = utils.keys(opts.servers),
        automatic_installation = false,
      }

      local all = vim.tbl_deep_extend('error', opts, local_servers)
      for server, config in pairs(all.servers) do
        lsp.setup_server(server, config)
      end
    end,
  },
}
