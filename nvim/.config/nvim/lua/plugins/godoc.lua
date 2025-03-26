return {
  'fredrikaverpil/godoc.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  build = 'go install github.com/lotusirous/gostdsym/stdsym@latest',
  cmd = { 'GoDoc' },
  opts = {
    picker = { 'telescope' },
  },
}
