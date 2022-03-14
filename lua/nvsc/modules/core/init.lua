local opt = vim.opt
local g = vim.g

local opts = CONFIG.opts.vim

for option, val in pairs(opts) do
  opt[option] = val
end

-- disable nvim intro
opt.shortmess:append("sIc")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

local globs = CONFIG.globals

for global, val in pairs(globs) do
  g[global] = val
end
