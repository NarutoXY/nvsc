local LOG = LOG
local UTILS = UTILS
local CONFIG = CONFIG

-- Bootstrap Packer
vim.cmd("packadd packer.nvim")

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

  vim.cmd("packadd packer.nvim")
  present, packer = pcall(require, "packer")

  if present then
    LOG.info("Packer cloned successfully.")
  else
    LOG.error("Couldn't clone packer !\nPacker path: ", packer_path, "\n", packer)
  end
end

local plugins = {
  -- Core
  ["wbthomason/packer.nvim"] = { opt = true },
  ["lewis6991/impatient.nvim"] = { opt = true },
  ["nathom/filetype.nvim"] = { opt = true },
  ["nvim-lua/plenary.nvim"] = { module = "plenary" },
  ["tami5/sqlite.lua"] = { module = "sqlite" },

  -- Colors
  ["themercorp/themer.lua"] = {
    opt = true,
    event = "BufEnter",
    config = function()
      require("nvsc.modules.plugin.config.others").themer()
    end,
  },

  -- Git
  ["lewis6991/gitsigns.nvim"] = {
    opt = true,
    config = function()
      require("nvsc.modules.plugin.config.others").gitsigns()
    end,
    event = "BufWinEnter",
  },

  -- Syntax highlighting
  ["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    config = function()
      require("nvsc.modules.plugin.config.treesitter")
    end,
    event = "BufReadPost",
    run = ":TSUpdate",
  },

  -- other treesitter goodies
  ["nvim-treesitter/playground"] = {
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    opt = true,
  },

  -- telescope
  ["nvim-telescope/telescope.nvim"] = {
    module = "telescope",
    cmd = "Telescope",
    config = function()
      require("nvsc.modules.plugin.config.telescope")
    end,
    requires = {
      {"nvim-telescope/telescope-fzf-native.nvim", make = true },
      {"nvim-telescope/telescope-frecency.nvim"},
      {"nvim-telescope/telescope-project.nvim"},
      {"nvim-telescope/telescope-file-browser.nvim"},
    },
  },
  -- Wordle
  ["shift-d/wordle.nvim"] = { command = "Wordle", branch = "finish-win" },
}

-- Remove defaults
if not(next(CONFIG.plugins.disable_plugins or {})) then plugins = UTILS.plugin.remove_defaults(plugins, CONFIG.plugins.disabled_plugins or {}) end

-- Append user plugins
if not(next(CONFIG.plugins.extra_plugins or {})) then plugins = UTILS.plugin.append_plugin(plugins, CONFIG.plugins.extra_plugins or {}) end

-- Override plugin table
if not(next(CONFIG.plugins.override_plugins or {})) then plugins = vim.tbl_deep_extend("force", plugins, CONFIG.plugins.override_plugins or {}) end

packer.init({
  git = { depth = 1 },
  compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  profile = { enable = true },
  display = {
    done_sym = "✓",
    error_sym = "×",
    working_sym = "",
    open_fn = function()
      return require("packer.util").float({
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      })
    end,
  },
})

local use = packer.use
packer.reset()

for plugin, plug_conf in pairs(plugins) do
  if type(plug_conf) == "table" then
    plug_conf[1] = plugin
    use(plug_conf)
  end
end
