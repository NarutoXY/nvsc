local themes = require("telescope.themes")
local actions_layout = require("telescope.actions.layout")
local actions = require("telescope.actions")

local mappings = {
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-o>"] = actions.select_vertical,
    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
    ["<C-h>"] = "which_key",
    ["<C-l>"] = actions_layout.toggle_preview,
    ["<C-d>"] = actions.preview_scrolling_up,
    ["<C-f>"] = actions.preview_scrolling_down,
    ["<C-n>"] = require("telescope.actions").cycle_history_next,
    ["<C-u>"] = require("telescope.actions").cycle_history_prev,
  },
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<c-p>"] = actions_layout.toggle_prompt_position,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-o>"] = actions.select_vertical,
    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
    ["<C-h>"] = "which_key",
    ["<C-l>"] = actions_layout.toggle_preview,
    ["<C-d>"] = actions.preview_scrolling_up,
    ["<C-f>"] = actions.preview_scrolling_down,
    ["<C-n>"] = require("telescope.actions").cycle_history_next,
    ["<C-u>"] = require("telescope.actions").cycle_history_prev,
  },
}

local theme = themes.get_ivy({
  selection_caret = "▸ ",
  prompt_prefix = "🔭",
  results_title = "~ Results ~",
  shorten_path = true,
  winblend = 0,
  use_less = true,
  layout_config = {
    width = 0.99,
    height = 0.5,
    anchor = "S",
    preview_cutoff = 20,
    prompt_position = "top",
    horizontal = {
      preview_width = 0.65,
    },
    vertical = {
      preview_width = 0.65,
      width = 0.9,
      height = 0.95,
      preview_height = 0.5,
    },

    flex = {
      preview_width = 0.65,
      horizontal = {
        preview_width = 0.9,
      },
    },
  },
  mappings = mappings,
  set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
})

if CONFIG.telescope_layout then
  theme = pcall(loadstring(CONFIG.telescope_layout))
end

require("telescope").setup({
  defaults = theme,
})
