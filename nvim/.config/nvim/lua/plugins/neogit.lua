return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    graph_style = 'kitty',
  },
  keys = {
    { '<leader>g', '<cmd>Neogit<cr>' },
  },
  cmd = {
    'Neogit',
  },
}
