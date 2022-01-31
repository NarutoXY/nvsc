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
