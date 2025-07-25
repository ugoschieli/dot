if not vim.g.vscode then
  require 'core.options'
  require 'core.keymaps'
  require 'core.autocommands'

  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup('plugins', {
    install = {
      colorscheme = { 'kanagawa' },
    },
    change_detection = {
      notify = false,
    },
    ui = {
      border = 'rounded',
    },
  })
end
