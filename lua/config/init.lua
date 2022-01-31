local config = {
  plugins = {
    extra_plugins = {
      {
        "~/projects/nvim_plugins/themer",
        config = function()
          require("themer").setup({
            colorscheme = "kanagawa",
            styles = {
              comment = { style = "italic" },
              ["function"] = { style = "italic" },
              functionbuiltin = { style = "italic" },
              variable = { style = "italic" },
              variableBuiltIn = { style = "italic" },
              parameter = { style = "italic" },
            },
          })
        end,
        event = "BufWinEnter",
      },
      {
        "~/projects/nvim_plugins/ytmmusic.lua",
        module = "ytmmusic",
      },
      {
        "~/projects/nvim_plugins/graphene.lua",
        cmd = "Graphene",
        config = function ()
          require("graphene").setup({       
	outputFile = string.format("$XDG_PICTURES_DIR/GRAPHENE_%s-%s-%s_%s-%s", os.date("%Y"), os.date("%m"), os.date("%d"), os.date("%H"), os.date("%M")),
          })
        end
      },
    },
  },
  preFunc = function() end,
  postFunc = function() 
    -- haha using dunst as vim.notify
    vim.notify = function(msg, level, opts)
      opts = opts or {}
      if level == vim.log.levels.ERROR then
        level = "critical"
      elseif level == vim.log.levels.WARN then
        level = "critical"
      else
        level = "low"
      end
      os.execute(string.format([[notify-send "NeoVim %s" "%s" -u %s]], opts.title or "", msg or "", level))
    end
  end,
}

return config
