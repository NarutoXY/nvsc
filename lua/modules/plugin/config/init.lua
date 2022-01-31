---@param plugin string plugin name
---@return bool or plugin config
return function(plugin)
  local ok, plug_config = pcall(require, string.format("modules.plugin.config.%s", plugin))
  if not ok then
    Log.error(string.format("Cannot find config for plugin %s", plugin))
    return false
  else
    return plug_config
  end
end
