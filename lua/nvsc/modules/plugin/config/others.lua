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

return plug_conf
