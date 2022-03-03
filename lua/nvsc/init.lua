-- GLOBALS
UTILS = require("nvsc.utils")
CONFIG = require("nvsc.config")()
LOG = require("nvsc.log")

if CONFIG.opts.nvsc.pre_func then
  UTILS.loadstring(CONFIG.opts.nvsc.pre_func, "pre_func")
end

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

if CONFIG.opts.nvsc.post_func then
  UTILS.loadstring(CONFIG.opts.nvsc.post_func, "post_func")
end
