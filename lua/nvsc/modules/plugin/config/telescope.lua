local themes = require("telescope.themes")
local actions_layout = require("telescope.actions.layout")
local actions = require("telescope.actions")

local mappings = {
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-o>"] = actions.select_vertical,
                ["<C-q>"] = actions.send_selected_to_qflist
                    + actions.open_qflist,
                ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
                ["<C-h>"] = "which_key",
                ["<C-l>"] = actions_layout.toggle_preview,
                ["<C-y>"] = set_prompt_to_entry_value,
                ["<C-d>"] = actions.preview_scrolling_up,
                ["<C-f>"] = actions.preview_scrolling_down,
                ["<C-n>"] = require("telescope.actions").cycle_history_next,
                ["<C-u>"] = require("telescope.actions").cycle_history_prev,
            },
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<c-p>"] = actions_layout.toggle_prompt_position,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-y>"] = set_prompt_to_entry_value,
                ["<C-o>"] = actions.select_vertical,
                ["<C-q>"] = actions.send_selected_to_qflist
                    + actions.open_qflist,
                ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
                ["<C-h>"] = "which_key",
                ["<C-l>"] = actions_layout.toggle_preview,
                ["<C-d>"] = actions.preview_scrolling_up,
                ["<C-f>"] = actions.preview_scrolling_down,
                ["<C-n>"] = require("telescope.actions").cycle_history_next,
                ["<C-u>"] = require("telescope.actions").cycle_history_prev,
            },
        }

mappings = vim.tbl_deep_extend("force", mappings, CONFIG.mappings.telescope)

require("telescope").setup({
	defaults = themes.get_ivy({
		selection_caret = "▸",
		prompt_prefix = "🔭",
		results_title = "~ Results ~",
		shorten_path = true,
		winblend = 20,
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
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("frecency")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")

