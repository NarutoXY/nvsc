local utils = {}

utils.fs = require("nvsc.utils.fs")

utils.plugin = {}

utils.tbl = {}

-- PLUGIN FUNCTIONS
utils.plugin.get_plugin_idx = function(plug, plug_tbl)
  for idx, plugin in pairs(plug_tbl) do
    if plugin[1] == plug then
      return idx
    end
  end
end

utils.plugin.remove_defaults = function(plug_tbl, conf)
  if #conf ~= 0 then
    for plug = 1, #conf do
      plug_idx = utils.plugin.get_plugin_idx(conf[plug], plug_tbl)
      plug_tbl[plug_idx] = nil
    end
  end
  return plug_tbl
end

utils.plugin.append_plugin = function(plug_tbl, conf)
  if #conf ~= 0 then
    for plug = 1, #conf do
      conf[plug][1] = conf[plug].plugin
      plug_tbl[#plug_tbl + 1] = conf[plug]
    end
  end
  return plug_tbl
end

---TBL FUNCTIONS
---Check if a table has given value
---@param tbl table
---@param val any
---@return boolean
utils.tbl.has_value = function(tbl, val)
  for index, value in ipairs(tbl) do
    if value == val then
      return true
    end
  end

  return false
end

return utils
