local LOG = LOG
local UTILS = UTILS
local CONFIG = CONFIG

local count = 0

--- Defer plugin loading
--- @param timer number time to defer by
local defer = function (timer)
  timer = timer or 1
  count = count + timer
  return count
end

-- Bootstrap Packer
-- vim.cmd("packadd packer.nvim")

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

local plugins = {
  -- Core
  ["wbthomason/packer.nvim"] = { opt = true, module = "packer" },
  ["lewis6991/impatient.nvim"] = {},
  ["nathom/filetype.nvim"] = { opt = true, event = { "BufNewFile", "BufRead" } },
  ["nvim-lua/plenary.nvim"] = { module = "plenary" },
  ["tami5/sqlite.lua"] = { module = "sqlite" },
  ["kyazdani42/nvim-web-devicons"] = { module = "nvim-web-devicons" },

  -- Colors
  ["themercorp/themer.lua"] = {
    opt = true,
    as = "themer",
    config = function()
      require("nvsc.modules.plugin.config.others").themer()
    end,
    defer = defer(1),
  },

  -- LSP
  ["neovim/nvim-lspconfig"] = {
    opt = true,
    defer = defer(2),
    config = function()
      require("nvsc.modules.plugin.config.lsp")
    end,
  },
  ["folke/lua-dev.nvim"] = { module = "lua-dev" },
  ["tami5/lspsaga.nvim"] = { module = "lspsaga", after = "nvim-lspconfig" },
  ["jose-elias-alvarez/null-ls.nvim"] = { module = "null-ls" },
  ["ahmedkhalf/project.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("project_nvim").setup({})
    end,
  },

  -- Git
  ["lewis6991/gitsigns.nvim"] = {
    opt = true,
    config = function()
      require("nvsc.modules.plugin.config.others").gitsigns()
    end,
    defer = defer(),
  },

  -- Syntax highlighting
  ["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    config = function()
      require("nvsc.modules.plugin.config.treesitter")
    end,
    defer = defer(),
    run = ":TSUpdate",
  },

  -- other treesitter goodies
  ["nvim-treesitter/playground"] = {
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    opt = true,
  },

  ["RRethy/nvim-treesitter-endwise"] = { after = "nvim-treesitter", config = function ()
    require('nvim-treesitter.configs').setup {
    endwise = {
        enable = true,
    },
}
  end },

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
  
  ["stevearc/dressing.nvim"] = {
    defer = defer(5),
    config = function ()
      require("dressing").setup({telescope = {theme = "ivy"}})
    end
  },

  -- colorizer
  ["norcalli/nvim-colorizer.lua"] = {
    after = "nvim-treesitter",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- mkdir
  ["jghauser/mkdir.nvim"] = {
    config = function()
      require("mkdir")
    end,
    event = "BufWritePre",
  },

  ["L3MON4D3/LuaSnip"] = {
    opt = true,
    requires = {
      "rafamadriz/friendly-snippets",
      after = "LuaSnip",
      event = { "InsertEnter", "CmdlineEnter" },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("nvsc.modules.plugin.config.snippets")
    end,
  },
  -- cmp
  ["hrsh7th/nvim-cmp"] = {
    after = "LuaSnip",
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


  -- neogen the best
  ["danymat/neogen"] = { module = "neogen", defer = defer(), config = function ()
    require("neogen").setup({})
  end },

  ["akinsho/bufferline.nvim"] = {
    config = function()
      require("nvsc.modules.plugin.config.tab")
    end,
    defer = defer(),
  },

  -- nvim tree
  ["kyazdani42/nvim-tree.lua"] = {
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("nvsc.modules.plugin.config.tree")
    end,
  },

  -- folke plugins go here
  ["folke/persistence.nvim"] = {
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },

  ["folke/trouble.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("trouble").setup({ use_diagnostic_sings = true })
    end,
  },

  ["folke/todo-comments.nvim"] = {
    config = function()
      require("todo-comments").setup()
    end,
    after = "nvim-treesitter",
  },

  ["folke/twilight.nvim"] = {
    config = function()
      require("twilight").setup()
    end,
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  },

  ["folke/zen-mode.nvim"] = {
    config = function()
      require("zen-mode").setup({})
    end,
    cmd = "ZenMode",
  },

  -- neoscroll
  ["karb94/neoscroll.nvim"] = {
    config = function()
      require("neoscroll").setup()
    end,
    event = { "CursorMoved", "CursorMovedI" },
  },

  -- notifications
  ["rcarriga/nvim-notify"] = { defer = defer(), config = function() vim.notify = require("notify") end, opt = true },
}

-- Remove defaults
plugins = UTILS.plugin.remove_defaults(plugins, CONFIG.plugins.disabled_plugins or {})

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
    if plug_conf.defer then
      plug_conf.opt = true
      plug_conf.setup = string.format([[
        vim.defer_fn(function()
          require("packer").loader("%s")
        end, %s)
      ]], plug_conf.as or string.match(plugin, "/(.*)"), plug_conf.defer)
    end
    plug_conf[1] = plugin
    use(plug_conf)
  end
end
