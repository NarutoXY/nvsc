---@class Utils
local utils = {}

---@class Utils.Fs with file system functions
utils.fs = {}

---@class Utils.Tbl with tbl functions
utils.tbl = {}

---@class Utils.Plugin with plugin functions
utils.plugin = {}

-- FILESYSTEM FUNCTIONS
--- Reads a file in the path
---@param path string file path
---@return string
utils.fs.read_file = function(path)
  local file = io.open(path, "rb") -- r read mode and b binary mode
  if not file then
    return nil
  end
  local content = file:read("*a") -- *a or *all reads the whole file
  file:close()
  return content
end

-- TBL FUNCTIONS
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

-- PLUGIN FUNCTIONS
---@param plug string plugin name
---@param time number
utils.plugin.lazy_load = function(plug, time)
  if plug then
    time = time or 0
    vim.defer_fn(function()
      require("packer").loader(plug)
    end, time)
  end
end

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
      plug_tbl[#plug_tbl + 1] = conf[plug]
    end
  end
  return plug_tbl
end

-- MISC FUNCTIONS
utils.reload = function (module)
    return require("plenary.reload").reload_module(module)  
end

return utils
