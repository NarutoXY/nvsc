-- Source: https://github.com/EdenEast/nyx/blob/8a9819e/config/.config/nvim/lua/eden/modules/ui/feline/init.lua

require("nvsc.utils.colors").gen_highlights()

local u = UTILS.ui
local fmt = string.format

-- "┃", "█", "", "", "", "", "", "", "●"

local get_diag = function(str)
  local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[str]})
  return (count > 0) and " " .. count .. " " or ""
end

local function vi_mode_hl()
  return u.vi.colors[vim.fn.mode()] or "FlnViBlack"
end

local function vi_sep_hl()
  return u.vi.sep[vim.fn.mode()] or "FlnBlack"
end

local c = {
  vimode = {
    provider = function()
      return string.format(" %s ", u.vi.text[vim.fn.mode()])
    end,
    hl = vi_mode_hl,
    right_sep = { str = " ", hl = vi_sep_hl },
  },
  gitbranch = {
    provider = "git_branch",
    icon = " ",
    hl = "FlnGitBranch",
    right_sep = { str = "  ", hl = "FlnGitBranch" },
    enabled = function()
      return vim.b.gitsigns_status_dict ~= nil
    end,
  },
  file_type = {
    provider = function()
      return fmt(" %s ", vim.bo.filetype:upper())
    end,
    hl = "FlnAlt",
  },
  fileinfo = {
    provider = { name = "file_info", opts = { type = "relative" } },
    hl = "FlnAlt",
    left_sep = { str = " ", hl = "FlnAltSep" },
    right_sep = { str = "", hl = "FlnAltSep" },
  },
  file_enc = {
    provider = function()
      local os = u.icons[vim.bo.fileformat] or ""
      return fmt(" %s %s ", os, vim.bo.fileencoding)
    end,
    hl = "StatusLine",
    left_sep = { str = u.icons.left_filled, hl = "FlnAltSep" },
  },
  cur_position = {
    provider = function()
      -- TODO: What about 4+ diget line numbers?
      return fmt(" %3d:%-2d ", unpack(vim.api.nvim_win_get_cursor(0)))
    end,
    hl = vi_mode_hl,
    left_sep = { str = u.icons.left_filled, hl = vi_sep_hl },
  },
  cur_percent = {
    provider = function()
      return " " .. require("feline.providers.cursor").line_percentage() .. "  "
    end,
    hl = vi_mode_hl,
    left_sep = { str = u.icons.left, hl = vi_mode_hl },
  },
  default = { -- needed to pass the parent StatusLine hl group to right hand side
    provider = "",
    hl = "StatusLine",
  },
  lsp_error = {
    provider = function()
      return get_diag("E")
    end,
    hl = "FlnError",
    left_sep = { str = "", hl = "FlnErrorStatus", always_visible = true },
    right_sep = { str = "", hl = "FlnWarnError", always_visible = true },
  },
  lsp_warn = {
    provider = function()
      return get_diag("W")
    end,
    hl = "FlnWarn",
    right_sep = { str = "", hl = "FlnInfoWarn", always_visible = true },
  },
  lsp_info = {
    provider = function()
      return get_diag("I")
    end,
    hl = "FlnInfo",
    right_sep = { str = "", hl = "FlnHintInfo", always_visible = true },
  },
  lsp_hint = {
    provider = function()
      return get_diag("H")
    end,
    hl = "FlnHint",
    right_sep = { str = "", hl = "FlnBgHint", always_visible = true },
  },

  in_fileinfo = {
    provider = "file_info",
    hl = "StatusLine",
  },
  in_position = {
    provider = "position",
    hl = "StatusLine",
  },
}

local active = {
  { -- left
    c.vimode,
    c.gitbranch,
    c.fileinfo,
    c.default, -- must be last
  },
  { -- right
    c.lsp_error,
    c.lsp_warn,
    c.lsp_info,
    c.lsp_hint,
    c.file_type,
    c.file_enc,
    c.cur_position,
    c.cur_percent,
  },
}

local inactive = {
  { c.in_fileinfo }, -- left
  { c.in_position }, -- right
}

require("feline").setup({
  components = { active = active, inactive = inactive },
  highlight_reset_triggers = {},
  force_inactive = {
    filetypes = {
      "NvimTree",
      "packer",
      "dap-repl",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "dapui_repl",
      "LspTrouble",
      "qf",
      "help",
    },
    buftypes = { "terminal" },
    bufnames = {},
  },
  disable = {
    filetypes = {
      "dashboard",
      "startify",
    },
  },
})
