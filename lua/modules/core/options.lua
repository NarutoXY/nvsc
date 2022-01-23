local opt = vim.opt
local g = vim.g

local options = {
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
}

opt.title = true
opt.clipboard = options.clipboard
opt.cmdheight = options.cmdheight
opt.cul = true -- cursor line

-- Indentline
opt.expandtab = options.expandtab
opt.shiftwidth = options.shiftwidth
opt.smartindent = options.smartindent

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = options.fillchars

opt.hidden = options.hidden
opt.ignorecase = options.ignorecase
opt.smartcase = options.smartcase
opt.mouse = options.mouse

-- Numbers
opt.number = options.number
opt.numberwidth = options.numberwidth
opt.relativenumber = options.relativenumber
opt.ruler = options.ruler

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.tabstop = options.tabstop
opt.termguicolors = true
opt.timeoutlen = options.timeoutlen
opt.undofile = options.undofile

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = options.updatetime

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

g.mapleader = options.mapleader

-- disable some builtin vim plugins
local disabled_built_ins = {
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
