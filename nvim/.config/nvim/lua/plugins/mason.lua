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

      local function keys(t)
        local key_t = {}
        for key, _ in pairs(t) do
          table.insert(key_t, key)
        end
        return key_t
      end

      local opts = {
        servers = {
          lua_ls = {},
          ts_ls = {},
          eslint = {},
          emmet_language_server = {},
          tailwindcss = {},
          dockerls = {},
          gopls = {},
        },
      }

      local local_servers = {
        servers = {
          rust_analyzer = {},
          clangd = {
            cmd = {
              'clangd',
              '--header-insertion=never',
            },
          },
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
        ensure_installed = keys(opts.servers),
      }

      for server, config in pairs(opts.servers) do
        lsp.setup_server(server, config)
      end

      for server, config in pairs(local_servers.servers) do
        lsp.setup_server(server, config)
      end
    end,
  },
}
