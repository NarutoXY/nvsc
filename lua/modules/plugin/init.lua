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

local has_val = Utils.tbl.has_value
local Config = Config

local pluginConfig = require("config").plugins.extraConfig or {}

local overconf = function(plug, conf)
	return pluginConfig[plug] or conf
end

local plugins = {
	-- Core
	{ "wbthomason/packer.nvim", opt = true },
	{ "lewis6991/impatient.nvim" },
	{ "nathom/filetype.nvim" },
	{
		"neovim/nvim-lspconfig",
		requires = {
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "ray-x/lsp_signature.nvim" },
			{ "folke/lua-dev.nvim" },
		},
	},
	{ "nvim-lua/plenary.nvim", module = "plenary" },
	{ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },

	-- Syntax and treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost",
		disable = not has_val(Config.plugin, "nvim-treesitter"),
		config = overconf("nvim-treesitter", [[require("modules.plugin.config.treesitter")]]),
		run = ":TSUpdate",
	},
	{
		"nvim-treesitter/playground",
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
		disable = not has_val(Config.plugin, "playground"),
	},

	-- tabline
	{
		"akinsho/nvim-bufferline.lua",
		config = overconf("nvim-bufferline.lua", [[require("modules.plugin.config.bufferline")]]),
		event = "BufWinEnter",
	},

  -- toggleterm
  {
    "akinsho/nvim-toggleterm.lua",
    config = overconf("nvim-toggleterm.lua", [[require("modules.plugin.config.toggleterm")]]),
    event = "BufWinEnter",
  },
	-- gitsigns and blankline
	{
		"lewis6991/gitsigns.nvim",
		config = overconf("gitsigns.nvim", [[require("modules.plugin.config.gitsigns")]]),
		event = "ColorScheme",
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = overconf("indent-blankline.nvim", [[require("modules.plugin.config.blankline")]]),
		event = "BufWinEnter",
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = overconf("telescope.nvim", [[require("modules.plugin.config.telescope")]]),
		disable = not has_val(Config.plugin, "telescope.nvim"),
		requires = {
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	},
	-- AutoCompletion
	{
		"iron-e/nvim-cmp",
		branch = "feat/completion-menu-borders",
		event = { "CmdLineEnter", "InsertEnter" },
		config = overconf("nvim-cmp", [[require("modules.plugin.config.cmp")]]),
		disable = not has_val(Config.plugin, "nvim-cmp"),
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
					require("modules.plugin.config.snippets")
				end,
			},
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-cmdline" },
		},
	},
	-- Annotation
	{
		"danymat/neogen",
		config = overconf(
			"neogen",
			[[require('neogen').setup {
            enabled = true
        }]]
		),
		module = "neogen",
		after = "nvim-treesitter",
		disable = not has_val(Config.plugin, "neogen"),
	},

	-- Mappings
  { "folke/which-key.nvim", event = "BufWinEnter" },
	{ "narutoxy/mappy.nvim", module = "mappy", after = "which-key.nvim"},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = overconf("nvim-autopairs", [[ require("modules.plugin.config.nvim_autopairs") ]]),
	},
}

plugins = Utils.plugin.remove_defaults(plugins, Config.removeDefaultPlugin or {})

-- Append user plugins
plugins = Utils.plugin.append_plugin(plugins, require("config").plugins.extra_plugins or {})

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

for plug = 1, #plugins do
	use(plugins[plug])
end
