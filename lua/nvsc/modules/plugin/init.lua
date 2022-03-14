local LOG = LOG
local UTILS = UTILS
local CONFIG = CONFIG

-- Bootstrap Packer
local present, packer = pcall(require, "packer")

if not present then
  local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

  LOG.info("Cloning packer..")
  -- remove the dir before cloning
  vim.fn.delete(packer_path, "rf")
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "1",
    packer_path,
  })

  -- vim.cmd("packadd packer.nvim")
  present, packer = pcall(require, "packer")

  if present then
    LOG.info("Packer cloned successfully.")
  else
    LOG.error("Couldn't clone packer !\nPacker path: ", packer_path, "\n", packer)
  end
end

local plugins = CONFIG.plugins.override_plugins

plugins = UTILS.plugin.remove_defaults(plugins, CONFIG.plugins.disabled_plugins or {})

packer.init(CONFIG.plugins.packer_config)

local use = packer.use
packer.reset()

for plugin, plug_conf in pairs(plugins) do
  if type(plug_conf) == "table" then
    if plug_conf.defer then
      plug_conf.opt = true
      plug_conf.setup = string.format(
        [[
        vim.defer_fn(function()
          require("packer").loader("%s")
        end, %s)
      ]],
        plug_conf.as or string.match(plugin, "/(.*)"),
        plug_conf.defer
      )
    end
    plug_conf[1] = plugin
    use(plug_conf)
  end
end
