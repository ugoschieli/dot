return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'windwp/nvim-ts-autotag', 'nvim-treesitter/nvim-treesitter-textobjects' },
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = 'all',
    highlight = { enable = true },
    autotag = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
          ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    -- local treesitter = require 'nvim-treesitter'
    -- treesitter.setup(opts)
    -- treesitter.install { 'all' }
    --
    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = { '<filetype>' },
    --   callback = function() vim.treesitter.start() end,
    -- })
  end,
}
