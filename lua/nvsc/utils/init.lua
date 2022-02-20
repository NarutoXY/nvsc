local utils = {}

utils.fs = require("nvsc.utils.fs")

utils.plugin = {}

utils.tbl = {}

-- PLUGIN FUNCTIONS
utils.plugin.remove_defaults = function(plug_tbl, conf)
  for _, plugin in ipairs(conf) do
plug_tbl[plugin] = nil
  end
  return plug_tbl
end

utils.plugin.append_plugin = function(plug_tbl, conf)
  for plugin, plug_conf in pairs(conf) do
  	plug_tbl[plugin] = plug_conf
  end
  return plug_tbl
end

---TBL FUNCTIONS
---Check if a table has given value
---@param tbl table
---@param val any
---@return boolean
utils.tbl.has_value = function(tbl, val)
  for _, value in ipairs(tbl) do
    if value == val then
      return true
    end
  end

  return false
end

return utils
