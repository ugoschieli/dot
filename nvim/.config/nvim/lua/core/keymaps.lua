local M = {}

---Keymap utility function
---@param rhs string
---@param lhs string|function
---@param desc string
---@param mode string?
---@param opts vim.keymap.set.Opts?
local function map(rhs, lhs, desc, mode, opts)
  mode = mode or 'n'
  opts = opts or {}
  vim.keymap.set(mode, rhs, lhs, vim.tbl_extend('force', opts, { desc = desc, noremap = true, silent = true }))
end

M.setup_keymaps = function()
  map('<leader>hl', function() vim.o.hlsearch = not vim.o.hlsearch end, 'Toggle search highlight')

  map('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
  map('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
  map('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
  map('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

  map('<leader>d', vim.diagnostic.open_float, 'Show line diagnostics')
  map('<leader>q', vim.diagnostic.setloclist, 'Open file diagnostics in quickfix list')
  -- map('<leader>Q', function()
  --   vim.diagnostic.setqflist()
  --   local qf_exists = false
  --   for _, win in pairs(vim.fn.getwininfo()) do
  --     if win['quickfix'] == 1 then qf_exists = true end
  --   end
  --   if qf_exists == true then
  --     vim.cmd 'cclose'
  --     return
  --   end
  --   if not vim.tbl_isempty(vim.fn.getqflist()) then vim.cmd 'copen' end
  -- end, 'Open project diagnostics in quickfix list')
  map('<leader>Q', vim.diagnostic.setqflist, 'Open project diagnostics in quickfix list')
  map('[d', function() vim.diagnostic.jump { count = 1, float = true } end, 'Go to next diagnostic')
  map(']d', function() vim.diagnostic.jump { count = -1, float = true } end, 'Go to previous diagnostic')
end

M.on_attach = function(_, buffer)
  local opts = { buffer = buffer }

  map('gD', vim.lsp.buf.declaration, 'Go to declaration', nil, opts)
  map('gd', vim.lsp.buf.definition, 'Go to definition', nil, opts)
  map('gi', vim.lsp.buf.implementation, 'Go to implementation', nil, opts)
  map('<leader>D', vim.lsp.buf.type_definition, 'Show type definition', nil, opts)
end

return M
