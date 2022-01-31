-- Mappy yay
require("mappy"):setup({
  version = "nightly",
})

-- default mappings
local mappings = {
  headings = {
    ["<leader>"] = {
      ["t"] = "Telescope",
      ["g"] = "Neogit",
      ["e"] = "Neogen",
    },
  },
  leader = {
    ["<leader>"] = {
      ["<leader>"] = ":w<cr>",
      ["s"] = ":so%<cr>",
      ["h"] = ":h<space>",
      -- Telescope
      ["fb"] = ":Telescope file_browser<cr>",
      ["t"] = {
        ["t"] = ":Telescope<cr>",
        ["g"] = ":Telescope live_grep<cr>",
        ["f"] = ":Telescope find_files<cr>",
        ["d"] = ":Telescope diagnostics<cr>",
        ["s"] = ":Telescope treesitter<cr>",
      },

      -- Neogit
      ["g"] = ":Neogit kind=split<cr>",

      -- Cheatsheet
      ["/"] = ":Cheatsheet<cr>",

      -- Neogen
      ["e"] = {
        ["e"] = ":Neogen file<cr>",
        ["f"] = ":Neogen func<cr>",
        ["c"] = ":Neogen class<cr>",
        ["t"] = ":Neogen type<cr>",
      },
    },
  },
  normal = {
    ["<C-n>"] = ":enew<cr>",
    ["<C-c>"] = ":bd<cr>",
    [";"] = ":",
  },
  insert = {},
}

mappings = vim.tbl_deep_extend("force", mappings, Config.mappings)

-- headings
local headings = require("mappy"):new()
headings:set_maps(mappings.headings)
headings:link()

-- leader maps
local leader = require("mappy"):new()
leader:set_maps(mappings.leader):map()

local normal = require("mappy"):new()
normal:set_maps(mappings.normal):map()

local insert = require("mappy"):new()
insert:set_maps(mappings.insert):set_opts({ mode = { "i", "c" } }):map()
