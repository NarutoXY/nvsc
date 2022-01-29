-- Bootstrap Packer
vim.cmd("packadd packer.nvim")

local present, packer = pcall(require, "packer")

if not present then
  local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

  Log.info("Cloning packer..")
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
    Log.info("Packer cloned successfully.")
  else
    Log.error("Couldn't clone packer !\nPacker path: ", packer_path, "\n", packer)
  end
end

-- Plugins
-- =======
-- packer options: https://github.com/wbthomason/packer.nvim#specifying-plugins
require("packer").startup({
  function(use)
    -- package manager
    use({ "wbthomason/packer.nvim", opt = true })

    use({
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient").enable_profile()
      end,
    })

    use({ "klen/plenary.nvim-1", module = "plenary" })

    -- create directories if they don't exist
    use({
      "jghauser/mkdir.nvim",
      config = function()
        require("mkdir")
      end,
      event = "BufWritePre",
    })

    use({
      "sainnhe/gruvbox-material"
    })
    use({
      "~/projects/nvim_plugins/themer",
      config = function()

        require("themer").setup({
    colorscheme = "gruvbox-material-dark-hard", -- default colorscheme
    transparent = false,
    dim_inactive = true,
    term_colors = true,
    styles = {
        ["function"] = { style = "italic" },
        functionBuiltIn = { style = "italic" },
        comment = { style = "bold" },
        constant = { style = "bold" },
        number = { style = "bold" },
        diagnostic = {
            underline = {
                error = { style = "underline" },
                warn = { style = "underline" },
            },
            virtual_text = {
                error = { style = "italic" },
                warn = { style = "italic" },
            },
        },
    },
    telescope_mappings = {
        ["n"] = {
            ["<CR>"] = "enter",
            ["k"] = "prev_color",
            ["j"] = "next_color",
            ["p"] = "preview",
        },
        ["i"] = {
            ["<CR>"] = "enter",
            ["<S-Tab>"] = "prev_color",
            ["<Tab>"] = "next_color",
            ["<C-p>"] = "preview",
        },
    },
})

      end,
      event = "BufWinEnter",
      module = "themer",
    })
  
    use({
      "~/projects/nvim_plugins/ytmmusic.lua/",
      module = "ytmmusic"
    })
    use({ "tami5/sqlite.lua", module = "sqlite" })

    -- better escape
    use({
      "max397574/betterEscape.nvim",
      event = { "InsertEnter" },
      config = function()
        require("better_escape").setup({
          mapping = { "jj" },
          keys = "<ESC>",
          timeout = 200,
        })
      end,
    })

    -- faster filetype detection
    use({
      "nathom/filetype.nvim",
      after = "impatient.nvim",
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      ft = "norg",
      config = function()
        require("modules.plugin.treesitter")
      end,
      event = "BufRead",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
          "romgrk/nvim-treesitter-context",
          event = "InsertEnter",
          config = function()
            require("treesitter-context.config").setup({
              enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            })
          end,
        },
      },
    })

    use({
      "nvim-treesitter/playground",
      cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    })

    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufWinEnter",
      setup = function()
        require("modules.plugin.blankline").setup()
      end,
    })

    -- floating terminal
    use({
      "akinsho/toggleterm.nvim",
      keys = { "<c-t>", "<leader>r", "<c-g>" },
      config = function()
        require("modules.plugin.toggleterm")
      end,
    })

    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      event = "BufWinEnter",
      config = function()
        require("modules.plugin.bufferline")
      end,
    })

    -- statusline
    use({
      "windwp/windline.nvim",
      event = "BufWinEnter",
      config = function()
        require("wlsample.bubble2")
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      event = "BufModifiedSet",
      opt = true,
      config = function()
        require("modules.plugin.gitsigns")
      end,
    })

    -- easily comment out code
    use({
      "numToStr/Comment.nvim",
      keys = { "<leader>c", "gb" },
      config = function()
        require("comment").setup({
          toggler = {
            ---line-comment keymap
            line = "<leader>cc",
            ---block-comment keymap
            block = "gbc",
          },

          ---LHS of operator-pending mappings in NORMAL + VISUAL mode
          opleader = {
            ---line-comment keymap
            line = "<leader>c",
            ---block-comment keymap
            block = "gb",
          },
          mappings = {
            extended = true,
          },
        })
      end,
    })

    -- easier use of f/F and t/T
    use({ "rhysd/clever-f.vim", keys = "f" })

    -- easily create md tables
    use({
      "dhruvasagar/vim-table-mode",
      cmd = "TableModeToggle",
    })

    -- -- display keybindings help
    use({
      opt = true,
      "max397574/which-key.nvim",
      event = "BufWinEnter",
      config = function()
        require("which-key").setup({})
        require("modules.plugin.which_key")
        require("modules.core.mappings")
      end,
      requires = {
        "narutoxy/mappy.nvim",
      },
    })

    use({
      "rcarriga/nvim-notify",
      opt = true,
      config = function()
        vim.notify = require("notify")
      end,
      event = "BufWinEnter",
    })

    use({
      "bfredl/nvim-luadev",
      cmd = "Luadev",
    })

    -- more helpfiles
    -- luv
    use("nanotee/luv-vimdocs")
    -- builtin lua functions
    use("milisims/nvim-luaref")

    -- make only certain areas or code accessible
    use({
      "chrisbra/NrrwRgn",
      cmd = { "NarrowRegion", "NarrowWindow" },
    })

    use({
      "nvim-neorg/neorg",
      -- branch = "better-concealing-performance",
      branch = "main",
      config = function()
        require("modules.plugin.neorg")
      end,
      ft = "norg",
      requires = {
        "terrortylor/neorg-telescope",
      },
    })

    use({
      "folke/zen-mode.nvim",
      config = [[require("modules.plugin.zenmode")]],
      cmd = "ZenMode",
      requires = {
        opt = true,
        "folke/twilight.nvim",
        config = function()
          require("twilight").setup({
            dimming = {
              alpha = 0.25,
              color = { "Normal", "#ffffff" },
              inactive = false,
            },
            context = 10,
            treesitter = true,
            expand = {
              "function",
              "method",
              "table",
              "if_statement",
            },
            exclude = {},
          })
        end,
      },
    })

    -- highlight and search todo comments
    use({
      "folke/todo-comments.nvim",
      cmd = { "TodoTelescope", "TodoTrouble", "TodoQuickFix" },
      config = [[ require("todo-comments").setup({}) ]],
    })

    -- change,add and delete surroundings
    use({
      "blackCauldron7/surround.nvim",
      config = function()
        require("surround").setup({
          mappings_style = "surround",
          pairs = {
            nestable = {
              { "(", ")" },
              { "[", "]" },
              { "{", "}" },
              { "/", "/" },
              {
                "*",
                "*",
              },
            },
            linear = { { "'", "'" }, { "`", "`" }, { '"', '"' } },
          },
        })
      end,
    })

    -- -- display last undos
    use({ "mbbill/undotree", cmd = "UndotreeToggle" })

    -- -- more icons
    use("ryanoasis/vim-devicons")

    -- -- even more icons
    use({
      "kyazdani42/nvim-web-devicons",
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
    })
    --
    use({
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutline",
      config = function()
        vim.cmd([[highlight FocusedSymbol gui=italic guifg=#56b6c2 ]])
      end,
    })

    -- a file explorer
    use({
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      module = { "telescope", "modules.plugin.telescope" },
      keys = { "<leader>Cs" },
      requires = {},
      config = [[ require("modules.plugin.telescope") ]],
    })
    use({ "nvim-lua/popup.nvim", after = "telescope.nvim" })
    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      after = "telescope.nvim",
    })
    use({ "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" })
    use({
      "nvim-telescope/telescope-file-browser.nvim",
      after = "telescope.nvim",
    })

    ---use({
    ---	"AckslD/nvim-neoclip.lua",
    ---	config = function()
    ---		require("neoclip").setup({
    ---			enable_persistant_history = true,
    ---			default_register_macros = "q",
    ---			enable_macro_history = true,
    ---			on_replay = {
    ---				set_reg = true,
    ---			},
    ---		})
    ---	end,
    ---})

    use({
      "max397574/startup.nvim",
      opt = true,
      config = [[ require("startup").setup(require("modules.plugin.startup_nvim")) ]],
    })

    -- colorize color codes
    use({
      "norcalli/nvim-colorizer.lua",
      keys = { "<leader>vc" },
      config = function()
        require("colorizer").setup({
          "*",
        }, {
          mode = "foreground",
          hsl_fn = true,
        })
        vim.cmd([[ColorizerAttachToBuffer]])
      end,
    })

    -- completition
    use({
      "hrsh7th/nvim-cmp",
      ft = "norg",
      event = { "InsertEnter", "CmdLineEnter" },
      config = [[ require("modules.plugin.cmp") ]],
      requires = {
        {
          "L3MON4D3/LuaSnip",
          opt = true,
          requires = {
            "rafamadriz/friendly-snippets",
            after = "LuaSnip",
            event = "InsertEnter",
          },
          event = "InsertEnter",
          after = "nvim-cmp",
          config = function()
            require("modules.plugin.snippets")
          end,
        },
      },
    })
    use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })

    use({
      "danymat/neogen",
      module = { "neogen" },
      config = function()
        require("neogen").setup({
          enabled = true,
          languages = {
            lua = {
              template = {
                emmylua = {
                  { nil, "-$1", { type = { "class", "func" } } }, -- add this string only on requested types
                  { nil, "-$1", { no_results = true } }, -- Shows only when there's no results from the granulator
                  { "parameters", "-@param %s $1|any" },
                  { "vararg", "-@vararg $1|any" },
                  { "return_statement", "-@return $1|any" },
                  { "class_name", "-@class $1|any" },
                  { "type", "-@type $1" },
                },
              },
            },
          },
        })
      end,
    })

    -- autopairs
    use({
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = [[ require("modules.plugin.nvim_autopairs") ]],
    })

    -- config for lsp
    use({
      "neovim/nvim-lspconfig",
      requires = {
        { "folke/lua-dev.nvim", opt = true, module = "lua-dev" },
        { "ray-x/lsp_signature.nvim", opt = true, module = "lsp_signature" },
      },
      config = function()
        require("modules.plugin.lsp")
      end,
    })

    -- show where lsp code action as available
    use({
      "kosayoda/nvim-lightbulb",
      after = "nvim-lspconfig",
      config = function()
        vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
      end,
    })

    -- some functions to refactor
    use({
      "ThePrimeagen/refactoring.nvim",
      config = function()
        require("modules.plugin.refactor")
      end,
      keys = { "<leader>R" },
    })

    -- list for lsp,quickfix,telescope etc
    use({
      "folke/trouble.nvim",
      cmd = { "Trouble", "TroubleToggle" },
      config = function()
        require("trouble").setup({
          auto_preview = false,
        })
      end,
    })
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    display = {
      title = "Packer",
      done_sym = "",
      error_syn = "×",
      keybindings = {
        toggle_info = "<TAB>",
      },
    },
  },
})
