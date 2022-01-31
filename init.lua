-- Impatient, yes i am
local present, impatient = pcall(require, "impatient")

if present then
  impatient.enable_profile()
end

-- Global vars (required many times)
Log = require("log")
Utils = require("utils")
Config = vim.json.decode(Utils.fs.read_file(string.format("%s/config.json", vim.fn.stdpath("config"))))

require("config").preFunc()

-- to load on startup
local core_modules = {
  "modules.core.options",
  "modules.statusline",
  "modules.plugin.config.lsp",
  "packer_compiled",
  "modules.plugin",
  "modules.core.mappings",
}

local load = function(core_modules)
  for k = 1, #core_modules do
    local ok, err = pcall(require, core_modules[k])
    if not ok then
      vim.notify(string.format("Error loading %s\n%s", core_modules[k], err), vim.log.levels.ERROR)
    end
  end
end

load(core_modules)

require("config").postFunc()
