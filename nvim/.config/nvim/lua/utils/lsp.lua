local M = {}

---@param server string
---@param config any
M.setup_server = function(server, config)
  local lspconfig = require 'lspconfig'
  local keymaps = require 'core.keymaps'
  local capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

  config = vim.tbl_deep_extend('force', {
    on_attach = keymaps.on_attach,
    capabilities = capabilities,
  }, config)

  lspconfig[server].setup(config)
end

return M
