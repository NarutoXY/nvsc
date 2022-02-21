local opt = vim.opt
local g = vim.g

local opts = {
  clipboard = "unnamedplus",
  cmdheight = 1,
  ruler = false,
  hidden = true,
  ignorecase = true,
  smartcase = true,
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
  fillchars = { eob = " " },
  title = true,
  cul = true,
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  shortmess = "sI",
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
}

opts = vim.tbl_deep_extend("force", opts, CONFIG.opts.vim)

for option, val in pairs(opts) do
  opt[option] = val
end

-- disable nvim intro
opt.shortmess:append(opts.shortmess)

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

g.mapleader = CONFIG.opts.nvsc.mapleader or " "
