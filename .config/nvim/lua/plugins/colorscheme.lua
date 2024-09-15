-- return {
--   'folke/tokyonight.nvim',
--   config = function() vim.cmd.colorscheme 'tokyonight' end,
-- }

return {
  'rebelot/kanagawa.nvim',
  opts = {
    colors = {
      palette = {
        sumiInk3 = '#000000',
      },
      theme = {
        all = {
          ui = {
            bg_gutter = 'none',
          },
        },
      },
    },
  },
  config = function(_, opts)
    require('kanagawa').setup(opts)
    require('kanagawa').load 'wave'
  end,
}

-- return {
--   'scottmckendry/cyberdream.nvim',
--   opts = {
--     transparent = true,
--   },
--   config = function(_, opts)
--     require('cyberdream').setup(opts)
--     vim.cmd.colorscheme 'cyberdream'
--   end,
-- }
