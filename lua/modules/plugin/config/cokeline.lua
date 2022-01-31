local get_hex = require("cokeline/utils").get_hex

require("cokeline").setup({
	default_hl = {
		focused = {
			fg = get_hex("Normal", "fg"),
			bg = get_hex("TabLine", "bg"),
		},
		unfocused = {
			fg = get_hex("Comment", "fg"),
			bg = get_hex("TabLine", "bg"),
		},
	},

	components = {
		{
			text = " ",
			hl = {
				bg = get_hex("Normal", "bg"),
			},
		},
		{
			text = "",
			hl = {
				fg = get_hex("TabLine", "bg"),
				bg = get_hex("Normal", "bg"),
			},
		},
		{
			text = function(buffer)
				return buffer.devicon.icon
			end,
			hl = {
				fg = function(buffer)
					return buffer.devicon.color
				end,
			},
		},
		{
			text = " ",
		},
		{
			text = function(buffer)
				return buffer.filename .. "  "
			end,
			hl = {
				style = function(buffer)
					return buffer.is_focused and "bold" or nil
				end,
			},
		},
		{
			text = "",
			delete_buffer_on_left_click = true,
		},
		{
			text = "",
			hl = {
				fg = get_hex("TabLine", "bg"),
				bg = get_hex("Normal", "bg"),
			},
		},
	},
})
