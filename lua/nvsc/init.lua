-- GLOBALS
UTILS = require("nvsc.utils")
CONFIG = require("nvsc.config")()
LOG = require("nvsc.log")

if CONFIG.opts.nvsc.pre_func then
  UTILS.loadstring(CONFIG.opts.nvsc.pre_func, "pre_func")
end

if CONFIG.opts.nvsc.profile then
  require("nvsc.utils.profile")
end

local modules = {
  start = { "nvsc.modules.core" },
  defer = {"nvsc.modules.plugin"},
}

local ok, err

for _, module in ipairs(modules.start) do
  ok, err = pcall(require, module)
  if not ok then
    LOG.error("Error loading ", module, "\n", err)
  end
end

for _, module in ipairs(modules.defer) do
  vim.defer_fn(function()
    ok, err = pcall(require, module)
    if not ok then
      LOG.error("Error loading ", module, "\n", err)
    end
  end, 10)
end

if CONFIG.opts.nvsc.post_func then
  UTILS.loadstring(CONFIG.opts.nvsc.post_func, "post_func")
end
