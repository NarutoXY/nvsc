local CONFIG = CONFIG

local plug_conf = {}

plug_conf.themer = function()
  require("themer").setup({
    colorscheme = CONFIG.opts.nvsc.colorscheme or "kanagawa",
    styles = {
      comment = { style = "italic" },
      ["function"] = { style = "italic" },
      functionbuiltin = { style = "italic" },
      variable = { style = "italic" },
      variableBuiltIn = { style = "italic" },
      parameter = { style = "italic" },
    },
  })
end

plug_conf.gitsigns = function()
  require("gitsigns").setup({})
end

plug_conf.treesitter_refactor = function()
  require("nvim-treesitter.configs").setup({
    refactor = {
      highlight_current_scope = { enable = true },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr",
        },
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>",
        },
      },
    },
  })
end

return plug_conf
