-- Global vars (required many times)
Log = require("log")

local core_modules = {
  "modules.core.options",
  "packer_compiled",
  "modules.plugin",
}

for k = 1, #core_modules do
  local ok, err = pcall(require, core_modules[k])
  if not ok then
    Log.error("Error loading ", core_modules[k], "\n", err)
  end
end
