return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      json = { 'prettierd' },
      vue = { 'prettierd' },
    },
    formatters = {
      ['clang-format'] = {
        prepend_args = { '--sort-includes=0', '--style=webkit' },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
