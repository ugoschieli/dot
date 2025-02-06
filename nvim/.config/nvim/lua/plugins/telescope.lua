return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  keys = {
    { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Find help' },
    {
      '<leader>fm',
      function() require('telescope.builtin').man_pages { sections = { 'ALL' } } end,
      desc = 'Find man pages',
    },
    { '<leader>fk', function() require('telescope.builtin').keymaps() end, desc = 'Find keymaps' },
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
    {
      '<leader>fw',
      function() require('telescope.builtin').grep_string() end,
      desc = 'Find current word',
    },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Find grep' },
    { '<leader>fs', function() require('telescope.builtin').lsp_document_symbols() end, desc = 'Find grep' },
    { '<leader>fS', function() require('telescope.builtin').lsp_workspace_symbols() end, desc = 'Find grep' },
    {
      '<leader>fd',
      function() require('telescope.builtin').diagnostics() end,
      desc = 'Find diagnostics',
    },
    { '<leader>fr', function() require('telescope.builtin').resume() end, desc = 'Find resume' },
    {
      '<leader>f.',
      function() require('telescope.builtin').oldfiles() end,
      desc = 'Find recent files',
    },
    {
      '<leader><leader>',
      function() require('telescope.builtin').buffers() end,
      desc = 'Find existing buffers',
    },
  },
  opts = {
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        hidden = true,
      },
      buffers = {
        sort_lastused = true,
        sort_mru = true,
        ignore_current_buffer = true,
        mappings = {
          i = {
            ['<C-d>'] = 'delete_buffer',
          },
        },
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension 'fzf'
  end,
}
