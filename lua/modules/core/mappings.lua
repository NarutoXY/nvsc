local map = vim.keymap.set
local nore_silent = { noremap = true, silent = true }
local nore = { noremap = true }
local wk = require("which-key")

wk.register({
  e = {
    name = "+Explore",
    f = {
      function()
        require("lir.float").init()
      end,
      "Float",
    },
    l = {
      function()
        require("lir").init()
      end,
      "Lir",
    },
    s = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" },
  },
  -- == Git ==
  g = {
    name = "+Git",
    s = {
      function()
        require("modules.plugin.telescope").git_status()
      end,
      "Status",
    },
    p = { "<cmd>Git push<CR>", "Push" },
    d = {
      function()
        require("modules.plugin.telescope").git_diff()
      end,
      "Diff",
    },
    l = { "<cmd>Telescope git_commits<CR>", "Log" },
    c = { "<cmd>Git commit<CR>", "Commit" },
    a = { "<cmd>Git add %<CR>", "Add" },
    h = {
      name = "+Hunk",
      s = "Stage",
      u = "Undo stage",
      r = "Reset",
      R = "Reset buffer",
      p = "Preview",
      b = "Blame line",
    },
  },
  c = {
    name = "+Comment, Clipboard, Colors",
    b = {
      function()
        require("telescope").extensions.neoclip.default()
      end,
      "Clipboard",
    },
    c = { "Toggle comment line" },
  },
  r = "Run",
  J = {
    function()
      require("tsht").jump_nodes()
    end,
    "Jump Around",
  },
  -- == Markdown ==
  m = {
    name = "Markdown, Messages",
    d = {
      name = "Markdown",
      h = {
        name = "Heading, HR",
        ["1"] = { "<cmd>MdHeading1<CR>", "Heading 1" },
        ["2"] = { "<cmd>MdHeading2<CR>", "Heading 2" },
        ["3"] = { "<cmd>MdHeading3<CR>", "Heading 3" },
        ["r"] = { "<cmd>MdHorizontalRule<CR>", "Horizontal Rule" },
      },
      a = { "<cmd>MdLink<CR>", "Link" },
      l = {
        name = "List",
        u = { "<cmd>MdUnorderedList<CR>", "Unordered" },
        o = { "<cmd>MdOrderedList<CR>", "Ordered" },
        t = { "<cmd>MdTaskList<CR>", "Task" },
      },
    },
  },
  -- == Errors ==
  x = {
    name = "+Errors",
    x = { "<cmd>TroubleToggle<CR>", "Trouble" },
    w = { "<cmd>Trouble lsp_workspace_diagnostics<CR>", "Workspace Trouble" },
    d = { "<cmd>Trouble lsp_document_diagnostics<CR>", "Document Trouble" },
    t = { "<cmd>TodoTrouble<CR>", "Todo Trouble" },
    T = { "<cmd>TodoTelescope<CR>", "Todo Telescope" },
    l = { "<cmd>lopen<CR>", "Open Location List" },
    q = { "<cmd>copen<CR>", "Open Quickfix List" },
  },
  Q = { ":let @q='<c-r><c-r>q", "Edit Macro Q" },
  t = {
    name = "+Table, Tasks",
    m = { "<cmd>TableModeToggle<CR>", "Toggle Table Mode" },
    t = { "Tabelize" },
    v = { "<cmd>Neorg gtd views<CR>", "View Tasks" },
    c = { "<cmd>Neorg gtd capture<CR>", "Capture Taks" },
    e = { "<cmd>Neorg gtd edit<CR>", "Edit Task" },
  },
  l = {
    name = "+Last, Load",
    f = { "<cmd>so<CR>", "Load File" },
    s = {
      function()
        require("modules.plugin.telescope").grep_last_search()
      end,
      "Grep Last Search",
    },
  },
  -- == Help ==
  ["h"] = {
    name = "+Help",
    t = { "<cmd>Telescope builtin<CR>", "Telescope" },
    c = { "<cmd>Telescope commands<CR>", "Commands" },
    h = {
      function()
        require("modules.plugin.telescope").help_tags()
      end,
      "Help Pages",
    },
    m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    k = { "<cmd>Telescope keymaps<CR>", "Key Maps" },
    -- s = { "<cmd>Telescope highlights<CR>", "Search Highlight Groups" },
    l = {
      [[<cmd>TSHighlightCapturesUnderCursor<CR>]],
      "Highlight Groups at cursor",
    },
    o = { "<cmd>Telescope vim_options<CR>", "Options" },
    f = {
      function()
        require("float_help").float_help()
      end,
      "Help Files",
    },
  },
  u = { "<cmd>UndotreeToggle<CR>", "UndoTree" },
  --== Buffers ==
  b = {
    name = "+Buffer",
    ["b"] = { "<cmd>e #<CR>", "Switch to Other Buffer" },
    ["p"] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
    ["["] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
    ["n"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
    ["]"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
    ["d"] = { "<cmd>bd<CR>", "Delete Buffer" },
    ["g"] = { "<cmd>BufferLinePick<CR>", "Goto Buffer" },
  },
  --== Search ==
  s = {
    name = "+Search",
    a = { "<cmd>Telescope autocommands<CR>", "Auto Commands" },
    g = {
      function()
        require("modules.plugin.telescope").find_string()
      end,
      "Grep",
    },
    b = {
      function()
        require("modules.plugin.telescope").curbuf()
      end,
      "Buffer",
    },
    d = { "<cmd>Telescope lsp_document_diagnostics<CR>", "Diagnostics" },
    B = { "<cmd>Telescope buffers<CR>", "Buffers" },
    e = {
      function()
        require("telescope.builtin").symbols({})
      end,
      "Emojis",
    },
    l = { "<cmd>Telescope luasnip<CR>", "Luasnip" },
    p = {
      function()
        require("modules.plugin.telescope").search_plugins()
      end,
      "Plugins",
    },
    y = {
      function()
        require("telescope").extensions.neoclip.default()
      end,
      "Yanks",
    },
    q = {
      function()
        require("telescope").extensions.macroscope.default()
      end,
      "Macros",
    },
    n = {
      function()
        require("telescope").extensions.notify.notify()
      end,
      "Notifications",
    },
    s = {
      function()
        require("telescope.builtin").lsp_workspace_symbols()
      end,
      "Goto Symbol",
    },
    h = { "<cmd>Telescope command_history<CR>", "Command History" },
    m = { "<cmd>Telescope marks<CR>", "Marks" },
    M = { "<cmd>messages<cr>", "Messages" },
    c = {
      function()
        require("modules.plugin.telescope").code_actions()
      end,
      "Code Actions",
    },
    t = { "<cmd>TodoTelescope<CR>", "Todo Comments" },
  },
  --== Files ==
  F = {
    name = "+File",
    r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    n = { "<cmd>enew<CR>", "New File" },
  },
  --== Find ==
  f = {
    name = "+Find",
    f = {
      function()
        require("modules.plugin.telescope").find_files()
      end,
      "File",
    },
    ["/"] = { "<cmd>Telescope grep_last_search<CR>", "Grep Last Search" },
    o = { "<cmd>Telescope oldfiles<CR>", "Oldfiles" },
    b = {
      "<cmd>Telescope buffers show_all_buffers=true<cr>",
      "Switch Buffer",
    },
    N = {
      function()
        require("modules.plugin.telescope").search_config()
      end,
      "Neovim Config",
    },
    h = {
      function()
        require("modules.plugin.telescope").help_tags()
      end,
      "Help Tags",
    },
    n = {
      function()
        require("modules.plugin.telescope").find_notes()
      end,
      "Notes",
    },
    B = { "<cmd>Telescope<CR>", "Builtin" },
    r = { "<cmd>Telescope registers<CR>", "Registers" },
    m = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
    a = { "<cmd>Telescope autocommands<CR>", "Autocommands" },
    O = { "<cmd>Telescope vim_options<CR>", "Vim Options" },
    c = { "<cmd>Telescope commands<CR>", "Commands" },
  },
  --== Insert ==
  i = {
    name = "+Insert",
    o = { "o<ESC>k", "Empty line below" },
    O = { "O<ESC>j", "Empty line above" },
    i = { "i <ESC>l", "Space before" },
    a = { "a <ESC>h", "Space after" },
    ["<CR>"] = { "i<CR><ESC>", "Linebreak at Cursor" },
  },
  a = {
    function()
      require("neogen").generate()
    end,
    "Generate Annotations",
  },
  ["."] = {
    function()
      require("modules.plugin.telescope").file_browser()
    end,
    "Browse Files",
  },
  ["/"] = {
    function()
      require("modules.plugin.telescope").find_string()
    end,
    "Live Grep",
  },
  [":"] = { "<cmd>Telescope commands<cr>", "Commands" },
  [","] = { "<cmd>Telescope buffers<cr>", "Buffers" },
  q = {
    name = "+Quickfix",
    n = { "<cmd>cnext<CR>", "Next Entry" },
    p = { "<cmd>cprevious<CR>", "Previous Entry" },
  },
  j = { ":m .+1<CR>==", "Move Current line down" },
  k = { ":m .-2<CR>==", "Move Current line up" },
  y = { '"+y', "Yank to clipboard" },
  p = { '"0p', "Paste last yanked text" },
  P = { '"0P', "Paste last yanked text" },
  --== Window ==
  w = {
    name = "+Window",
    ["w"] = { "<C-W>p", "other-window" },
    ["d"] = { "<C-W>c", "delete-window" },
    ["-"] = { "<C-W>s", "split-window-below" },
    ["|"] = { "<C-W>v", "split-window-right" },
    ["2"] = { "<C-W>v", "layout-double-columns" },
    ["h"] = { "<C-W>h", "window-left" },
    ["j"] = { "<C-W>j", "window-below" },
    ["l"] = { "<C-W>l", "window-right" },
    ["k"] = { "<C-W>k", "window-up" },
    ["H"] = { "<C-W>5<", "expand-window-left" },
    ["J"] = { ":resize +5<CR>", "expand-window-below" },
    ["L"] = { "<C-W>5>", "expand-window-right" },
    ["K"] = { ":resize -5<CR>", "expand-window-up" },
    ["="] = { "<C-W>=", "balance-window" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
  },
  v = {
    name = "+View",
    l = {
      function()
        require("utils").LatexPreview()
      end,
      "Latex",
    },
    m = {
      function()
        require("utils").MarkdownPreview()
      end,
      "Markdown",
    },
    -- c = {"<cmd>ColorizerAttachToBuffer<CR>", "Colorizer"},
    c = { "<cmd>PackerLoad nvim-colorizer.lua<CR>", "Colorizer" },
  },
}, {
  prefix = "<leader>",
  mode = "n",
})
wk.register({
  R = {
    name = "+Refactor",
    t = { "" },
  },
}, {
  prefix = "<leader>",
  mode = "n",
})

-- Windows
-- =======
-- easy split navigation
map("n", "<c-j>", ":wincmd j<CR>", nore_silent)
map("n", "<c-h>", ":wincmd h<CR>", nore_silent)
map("n", "<c-k>", ":wincmd k<CR>", nore_silent)
map("n", "<c-l>", ":wincmd l<CR>", nore_silent)
-- move windows with arrows
map("n", "<down>", ":wincmd J<CR>", nore_silent)
map("n", "<left>", ":wincmd H<CR>", nore_silent)
map("n", "<up>", ":wincmd K<CR>", nore_silent)
map("n", "<right>", ":wincmd L<CR>", nore_silent)

map("n", "°", ":normal! zO<CR>", nore_silent)

-- Telescope
-- =========
map("n", "<c-s>", function()
  require("modules.plugin.telescope").curbuf()
end, nore_silent)

-- Simple Commands (Improvements of commands)
-- ==========================================

map("n", "S", "<cmd>w<CR>", nore_silent)

-- highlight search result and center cursor
map("n", "n", "nzzzv", nore_silent)
map("n", "N", "Nzzzv", nore_silent)

-- reselect selection after shifting
map("x", "<", "<gv", nore)
map("x", ">", ">gv", nore)

-- move lines up and down in insert mode
map("i", "<C-j>", "<ESC>:m .+1<CR>==i<RIGHT>", nore)
map("i", "<C-k>", "<ESC>:m .-2<CR>==i<RIGHT>", nore)

-- remove highlighting from search
map("n", "nh", ":nohlsearch<CR>", nore_silent)
map("n", "<ESC>", "<cmd>nohl<CR>", nore_silent)
-- easier escape
map("v", "jk", "<ESC>", nore)

-- paste over selected text without overwriting yank register
map("v", "<leader>p", '"_dP', nore)

-- see registers
vim.keymap.set("n", "®", function()
  require("which-key").show("@", { mode = "n", auto = true })
end, nore_silent)

-- move visual blocks up and down
map("v", "J", ":m '>+1<CR>gv=gv", nore_silent)
map("v", "K", ": m'<-2<CR>gv=gv", nore_silent)

-- don't move cursor down when joining lines
map("n", "J", "mzJ`z", nore)
map("x", "<BS>", "x", nore)

-- substitute on visual selection
map("v", "<leader>s", ":s///g<LEFT><LEFT><LEFT>", nore)

-- Random
-- ======

-- move right in insert mode
map("i", "  ", "<RIGHT>", nore)

-- better undo
map("i", ",", ",<c-g>u", nore)
map("i", "!", "!<c-g>u", nore)
map("i", ".", ".<c-g>u", nore)
map("i", " ", " <c-g>u", nore)
map("i", "?", "?<c-g>u", nore)
map("i", "_", "_<c-g>u", nore)
map("i", "<CR>", "<CR><c-g>u", nore)

-- Close toggleterm
map("t", "<c-t>", "<cmd>ToggleTerm<CR>", nore_silent)
map("t", "<c-g>", "<cmd>ToggleTerm<CR>", nore_silent)

-- lsp
map("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", nore_silent)

-- help from ts with textobjects
map("o", "m", ":<C-U>lua require('tsht').nodes()<CR>", { silent = true })
map("v", "m", ":<C-U>lua require('tsht').nodes()<CR>", nore_silent)

-- open helpfile of word under cursor
map("n", "<C-f>", ':lua vim.cmd(":vert :h "..vim.fn.expand("<cword>"))<CR>', nore_silent)

-- jump to mark m
map("n", "M", "`m", nore_silent)

-- append comma and semicolon
map("n", ",,", function()
  require("utils").append_comma()
end, nore_silent)
map("n", ";;", function()
  require("utils").append_semicolon()
end, nore_silent)

-- change case of cword
map("n", "<C-U>", "b~", nore_silent)
map("i", "<C-U>", "<ESC>b~A", nore_silent)

map("v", "<leader>n", ":norm ", nore_silent)

-- luasnip
map("i", "<leader><tab>", function()
  require("luasnip").expand_or_jump()
end, nore_silent)
-- add j and k with count to jumplist
map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j']], { noremap = true, expr = true })
map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k']], { noremap = true, expr = true })

map("n", "<Leader>?", ":TodoQuickFix<CR>", nore)

-- Refactor.nvim

local opts = { noremap = true, silent = true, expr = false }

map("n", "<leader>Rp", ":lua require('refactoring').debug.printf({below = false})<CR>", { noremap = true })

-- Print var: this remap should be made in visual mode
map("v", "<leader>Rv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })

-- Cleanup function: this remap should be made in normal mode
vim.keymap.set("n", "<leader>Rc", function()
  require("refactoring").debug.cleanup({})
end, {
  noremap = true,
})

-- Remap to open the Telescope refactoring menu in visual mode
map("v", "<Leader>Rt", [[ <Esc><Cmd>lua require"modules.plugin.refactor".refactors()<CR>]], opts)
map("v", "<Leader>Re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opts)
map("v", "<Leader>Rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], opts)
map("v", "<Leader>Rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], opts)

map("v", "<Leader>Ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)
