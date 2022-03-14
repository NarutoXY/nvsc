local utils = {}

utils.fs = require("nvsc.utils.fs")
utils.plugin = {}

utils.tbl = {}

-- HELPER FUNCTIONS
---@param string string the string to load
---@param scope string the scope of the loadstring call
utils.loadstring = function(string, scope)
  local ok, err = pcall(loadstring(string))
  if not ok then
    LOG.error("Error loading function ", scope, "\n", err)
  end
end

utils.inspect = function(...)
  print(vim.inspect(...))
end

-- PLUGIN FUNCTIONS
utils.plugin.remove_defaults = function(plug_tbl, conf)
  for _, plugin in ipairs(conf) do
    plug_tbl[plugin] = nil
  end
  return plug_tbl
end

utils.plugin.count = 0

--- Defer plugin loading
--- @param timer number time to defer by
utils.plugin.defer = function(timer)
  timer = timer or 1
  utils.plugin.count = utils.plugin.count + timer
  return utils.plugin.count
end

---TBL FUNCTIONS

return utils
