local opt = vim.opt
local g = vim.g

local opts = {
  -- General configuration
  termguicolors = true,
  showmode = false,

  -- Enable mouse support
  mouse = "a",
  mousefocus = true,

  -- Enable line numbers and relative numbers
  number = true,
  relativenumber = true,

  -- Used by which-key.nvim
  timeoutlen = 500,

  -- Update the editor more frequently
  updatetime = 100,

  -- Start scrolling when we are 5 lines away from margins
  scrolloff = 5,

  -- Disable wrapping
  wrap = false,

  -- Make vim's default splitting directions something reasonable
  splitbelow = true,
  splitright = true,

  -- Synchronize the system clipboard with neovim's
  clipboard = "unnamedplus",

  -- Make sure the statusline is always shown
  laststatus = 2,

  -- Stop neovim from waiting after escape has been pressed
  ttimeoutlen = 5,

  -- Set up indenting
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,

  -- Allow us to edit text that doesn't classify as characters
  -- in visual block mode
  virtualedit = "block",

  -- Show previews for substitutions etc.
  inccommand = "split",

  -- Make search results case insensitive
  ignorecase = true,

  -- Enable undo files for every buffer
  undofile = true,

  -- Enable smart indentation
  autoindent = true,
  smartindent = true,
  copyindent = true,
  preserveindent = true,
}

opts = vim.tbl_deep_extend("force", opts, CONFIG.opts.vim)

for option, val in pairs(opts) do
  opt[option] = val
end

-- disable nvim intro
opt.shortmess:append("sIc")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

g.mapleader = CONFIG.opts.nvsc.mapleader or " "
