local fs = {}

--- Reads a file in the path
---@param path string file path
---@return string
fs.read_file = function(path)
  local file = io.open(path, "rb") -- r read mode and b binary mode
  if not file then
    return nil
  end
  local content = file:read("*a") -- *a or *all reads the whole file
  file:close()
  return content
end

return fs
