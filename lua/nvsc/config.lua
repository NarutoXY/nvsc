local options = {}

local load_user_config = function()
	local user_config_toml = UTILS.fs.read_file(string.format("%s/config.toml", vim.fn.stdpath("config")))
	local user_config = require("nvsc.toml").parse(user_config_toml) or {}
	return vim.tbl_deep_extend("force", options, user_config)
end

return load_user_config
