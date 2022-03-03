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
  ["lewis6991/impatient.nvim"] = {
    opt = true,
    config = function()
      require("impatient")
    end,
    event = "VimEnter",
  },
  ["nathom/filetype.nvim"] = { opt = true, after = "impatient.nvim" },
  ["nvim-lua/plenary.nvim"] = { module = "plenary" },
  ["tami5/sqlite.lua"] = { module = "sqlite" },
  ["kyazdani42/nvim-web-devicons"] = { module = "nvim-web-devicons" },

  -- LSP
  ["neovim/nvim-lspconfig"] = {
    opt = true,
    after = "nvim-treesitter",
    config = function()
      require("nvsc.modules.plugin.config.lsp")
    end,
  },
  ["folke/lua-dev.nvim"] = { module = "lua-dev" },
  ["jose-elias-alvarez/null-ls.nvim"] = { module = "null-ls" },

  -- Colors
  ["themercorp/themer.lua"] = {
    opt = true,
    as = "themer",
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
    event = "BufRead",
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

  ["windwp/nvim-autopairs"] = {
    config = function()
      require("nvsc.modules.plugin.config.others").autopairs()
    end,
    after = "nvim-treesitter",
    opt = true,
  },

  -- telescope
  ["nvim-telescope/telescope.nvim"] = {
    module = "telescope",
    cmd = "Telescope",
    config = function()
      require("nvsc.modules.plugin.config.telescope")
    end,
  },

  ["nvim-telescope/telescope-frecency.nvim"] = {
    config = function()
      require("telescope").load_extension("frecency")
    end,
    after = "telescope.nvim",
  },
  ["nvim-telescope/telescope-file-browser.nvim"] = {
    config = function()
      require("telescope").load_extension("file_browser")
    end,
    after = "telescope.nvim",
  },
  ["nvim-telescope/telescope-fzy-native.nvim"] = {
    config = function()
      require("telescope").load_extension("fzy_native")
    end,
    after = "telescope.nvim",
  },

  -- mkdir
  ["jghauser/mkdir.nvim"] = {
    config = function()
      require("mkdir")
    end,
    event = "BufWritePre",
  },

  -- cmp
  ["hrsh7th/nvim-cmp"] = {
    event = { "CmdlineEnter", "InsertEnter" },
    config = function()
      require("nvsc.modules.plugin.config.cmp")
    end,
    branch = "dev",
  },
  ["hrsh7th/cmp-nvim-lsp-document-symbol"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-nvim-lua"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-buffer"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-cmdline"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-path"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-nvim-lsp"] = { module = "cmp_nvim_lsp" },
  ["hrsh7th/cmp-omni"] = { after = "nvim-cmp" },
  ["saadparwaiz1/cmp_luasnip"] = { after = "nvim-cmp" },
  ["onsails/lspkind-nvim"] = { after = "nvim-cmp" },

  ["L3MON4D3/LuaSnip"] = {
    opt = true,
    requires = {
      "rafamadriz/friendly-snippets",
      after = "LuaSnip",
      event = "InsertEnter",
    },
    event = "InsertEnter",
    after = "nvim-cmp",
    config = function()
      require("nvsc.modules.plugin.config.snippets")
    end,
  },

  -- neogen the best
  ["danymat/neogen"] = { module = "neogen" },

  -- statusline
  ["feline-nvim/feline.nvim"] = {
    config = function()
      require("nvsc.modules.plugin.config.statusline")
    end,
    event = "ColorScheme",
  },
}

-- Remove defaults
plugins = UTILS.plugin.remove_defaults(plugins, CONFIG.plugins.disabled_plugins or {})

-- Append user plugins
plugins = UTILS.plugin.append_plugin(plugins, CONFIG.plugins.extra_plugins or {})

-- Override plugin table
plugins = vim.tbl_deep_extend("force", plugins, CONFIG.plugins.override_plugins or {})

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
