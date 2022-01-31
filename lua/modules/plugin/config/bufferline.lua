require("bufferline").setup({
  options = {
    numbers = "none",
    separator_style = "slant",
    sort_by = "directory",
    show_buffer_close_icons = false,
    show_close_icon = false,
    tab_size = 20,
    offsets = {
      {
        filetype = "NvimTree",
        text = "  NvimTree",
        text_align = "left",
        highlight = "WarningMsg",
      },
      {
        filetype = "packer",
        text = " Packer",
        text_align = "center",
        highlight = "WarningMsg",
      },
    },

    -- TODO
    custom_areas = {},
  },

  highlights = {
    tab = {
      guibg = {
        attribute = "bg",
        highlight = "TabLine",
      },
    },
    buffer_selected = {
      gui = "none",
    },
  },
})
