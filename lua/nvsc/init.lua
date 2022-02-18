-- GLOBALS
UTILS = require("nvsc.utils")
CONFIG = require("nvsc.config")()
LOG = require("nvsc.log")

local modules = {
  "nvsc.modules.core",
  "nvsc.modules.plugin",
}

local ok, err

for _, module in ipairs(modules) do
  ok, err = pcall(require, module)
  if not ok then
    LOG.error("Error loading ", module, "\n", err)
  end
end
