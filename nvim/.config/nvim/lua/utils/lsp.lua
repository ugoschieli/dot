local M = {}

---@param server string
---@param config any
function M.setup_server(server, config)
  local keymaps = require 'core.keymaps'
  local capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

  config = vim.tbl_deep_extend('force', {
    on_attach = keymaps.on_attach,
    capabilities = capabilities,
  }, config)

  -- lspconfig[server].setup(config)
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

return M
