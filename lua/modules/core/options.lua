local opt = vim.opt
local g = vim.g

local opts = {
  clipboard = "unnamedplus",
  cmdheight = 1,
  ruler = false,
  hidden = true,
  ignorecase = true,
  smartcase = true,
  mapleader = " ",
  mouse = "a",
  number = true,
  numberwidth = 2,
  relativenumber = true,
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  tabstop = 2,
  timeoutlen = 400,
  updatetime = 100,
  undofile = true,
  undodir = "/home/naruto/.cache/nvim/undo",
  fillchars = { eob = " " },
  title = true,
  cul = true,
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  shortmess = "sI",
}

opts = vim.tbl_deep_extend("force", opts, Config.opts)

local set_opts = function(key, val)
  opt[key] = val
end

for k, v in pairs(opts) do
  pcall(set_opts, k, v)
end

-- disable nvim intro
opt.shortmess:append(opts.shortmess)

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

g.mapleader = opts.mapleader

-- disable some builtin vim plugins
local disabled_built_ins = {
  "did_load_filetype",
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for k = 1, #disabled_built_ins do
  g["loaded_" .. disabled_built_ins[k]] = 1
  Log.trace("Disabled ", disabled_built_ins[k])
end
