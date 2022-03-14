local override_plugins = {
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
    defer = UTILS.plugin.defer(),
  },

  -- LSP
  ["neovim/nvim-lspconfig"] = {
    opt = true,
    defer = UTILS.plugin.defer(),
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

  -- cmp_nvim
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

  -- Git
  ["lewis6991/gitsigns.nvim"] = {
    opt = true,
    config = function()
      require("nvsc.modules.plugin.config.others").gitsigns()
    end,
    defer = UTILS.plugin.defer(),
  },

  -- Syntax highlighting
  ["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    config = function()
      require("nvsc.modules.plugin.config.treesitter")
    end,
    defer = UTILS.plugin.defer(),
    run = ":TSUpdate",
  },

  -- other treesitter goodies
  ["nvim-treesitter/playground"] = {
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    opt = true,
  },

  ["RRethy/nvim-treesitter-endwise"] = {
    after = "nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        endwise = {
          enable = true,
        },
      })
    end,
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

  ["stevearc/dressing.nvim"] = {
    defer = UTILS.plugin.defer(5),
    config = function()
      require("dressing").setup({ telescope = { theme = "ivy" } })
    end,
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

  -- neogen the best
  ["danymat/neogen"] = {
    module = "neogen",
    defer = UTILS.plugin.defer(),
    config = function()
      require("neogen").setup({})
    end,
  },

  ["akinsho/bufferline.nvim"] = {
    config = function()
      require("nvsc.modules.plugin.config.tab")
    end,
    defer = UTILS.plugin.defer(),
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
  ["rcarriga/nvim-notify"] = {
    defer = UTILS.plugin.defer(),
    config = function()
      vim.notify = require("notify")
    end,
    opt = true,
  },
}

local packer_config = {
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
}

local globals = {
  mapleader = " ",
}

local vim_opts = {
  -- General configuration
  termguicolors = true,
  showmode = false,

  -- Enable mouse support
  mouse = "a",
  mousefocus = true,

  -- Enable line numbers and relative numbers
  number = true,
  relativenumber = true,

  -- Used by which-key.nvim
  timeoutlen = 500,

  -- Update the editor more frequently
  updatetime = 100,

  -- Start scrolling when we are 5 lines away from margins
  scrolloff = 5,

  -- Disable wrapping
  wrap = false,

  -- Make vim's default splitting directions something reasonable
  splitbelow = true,
  splitright = true,

  -- Synchronize the system clipboard with neovim's
  clipboard = "unnamedplus",

  -- Make sure the statusline is always shown
  laststatus = 2,

  -- Stop neovim from waiting after escape has been pressed
  ttimeoutlen = 5,

  -- Set up indenting
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,

  -- Allow us to edit text that doesn't classify as characters
  -- in visual block mode
  virtualedit = "block",

  -- Show previews for substitutions etc.
  inccommand = "split",

  -- Make search results case insensitive
  ignorecase = true,

  -- Enable undo files for every buffer
  undofile = true,

  -- Enable smart indentation
  autoindent = true,
  smartindent = true,
  copyindent = true,
  preserveindent = true,
}

local options = {
  plugins = {
    override_plugins = override_plugins,
    packer_config = packer_config,
  },
  globals = globals,
  opts = {
    vim = vim_opts,
  },
}

local load_user_config = function()
  local user_config_toml = UTILS.fs.read_file(string.format("%s/config.toml", vim.fn.stdpath("config")))
  local user_config = require("nvsc.toml").parse(user_config_toml) or {}
  return vim.tbl_deep_extend("force", options, user_config)
end

return load_user_config
