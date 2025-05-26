local M = {}

--- return a list of all the keys in the provided table
---@param t table
---@return table
function M.keys(t)
  local key_t = {}
  for key, _ in pairs(t) do
    table.insert(key_t, key)
  end
  return key_t
end

return M
