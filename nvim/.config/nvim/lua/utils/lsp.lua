local M = {}

---@param server_name string
---@param opts any
M.setup_server = function(server_name, opts)
  local lspconfig = require 'lspconfig'
  local keymaps = require 'core.keymaps'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
  }

  opts = vim.tbl_deep_extend('force', {
    on_attach = keymaps.on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }, opts)
  lspconfig[server_name].setup(opts)
end

return M
