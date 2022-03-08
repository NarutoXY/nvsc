local colors = {}

local function highlight(group, color)
  vim.api.nvim_set_hl(0, group, color)
end

local function fromhl(hl)
  local result = {}
  local list = vim.api.nvim_get_hl_by_name(hl, true)
  for k, v in pairs(list) do
    local name = k == "background" and "bg" or "fg"
    _, result[name] = pcall(string.format, "#%06x", v)
  end
  return result
end

local function term(num, default)
  local key = "terminal_color_" .. num
  return vim.g[key] and vim.g[key] or default
end

local function colors_from_theme()
  return {
    bg = fromhl("StatusLine").bg or "#2E3440",
    sel = fromhl("ThemerSelected").bg or fromhl("TelescopeSelection").bg or "#2E3440",
    alt = fromhl("NormalFloat").bg or "#475062",
    fg = fromhl("Normal").bg or "#ECEFF4",
    hint = fromhl("DiagnosticHint").fg,
    info = fromhl("DiagnosticInfo").fg,
    warn = fromhl("DiagnosticWarn").fg,
    err = fromhl("DiagnosticError").fg,
    black = term(0, "#434C5E"),
    red = term(1, "#EC5F67"),
    green = term(2, "#8FBCBB"),
    yellow = term(3, "#EBCB8B"),
    blue = term(4, "#5E81AC"),
    magenta = term(5, "#B48EAD"),
    cyan = term(6, "#88C0D0"),
    white = term(7, "#ECEFF4"),
  }
end

colors.gen_highlights = function()
  local c = colors_from_theme()
  local sfg = vim.o.background == "dark" and c.black or c.white
  local sbg = vim.o.background == "dark" and c.white or c.black
  colors.colors = c
  local groups = {
    FlnViBlack = { fg = c.white, bg = c.black, bold = true },
    FlnViRed = { fg = c.bg, bg = c.red, bold = true },
    FlnViGreen = { fg = c.bg, bg = c.green, bold = true },
    FlnViYellow = { fg = c.bg, bg = c.yellow, bold = true },
    FlnViBlue = { fg = c.bg, bg = c.blue, bold = true },
    FlnViMagenta = { fg = c.bg, bg = c.magenta, bold = true },
    FlnViCyan = { fg = c.bg, bg = c.cyan, bold = true },
    FlnViWhite = { fg = c.bg, bg = c.white, bold = true },

    FlnBlack = { fg = c.black, bg = c.white, bold = true },
    FlnRed = { fg = c.red, bg = c.bg, bold = true },
    FlnGreen = { fg = c.green, bg = c.bg, bold = true },
    FlnYellow = { fg = c.yellow, bg = c.bg, bold = true },
    FlnBlue = { fg = c.blue, bg = c.bg, bold = true },
    FlnMagenta = { fg = c.magenta, bg = c.bg, bold = true },
    FlnCyan = { fg = c.cyan, bg = c.bg, bold = true },
    FlnWhite = { fg = c.white, bg = c.bg, bold = true },

    -- Diagnostics
    FlnHint = { fg = c.black, bg = c.hint, bold = true },
    FlnInfo = { fg = c.black, bg = c.info, bold = true },
    FlnWarn = { fg = c.black, bg = c.warn, bold = true },
    FlnError = { fg = c.black, bg = c.err, bold = true },
    FlnStatus = { fg = sfg, bg = sbg, bold = true },

    -- Dianostic Seperators
    FlnBgHint = { fg = c.sel, bg = c.hint },
    FlnHintInfo = { fg = c.hint, bg = c.info },
    FlnInfoWarn = { fg = c.info, bg = c.warn },
    FlnWarnError = { fg = c.warn, bg = c.err },
    FlnErrorStatus = { fg = c.err, bg = c.bg },
    FlnStatusBg = { fg = sbg, bg = c.bg },

    FlnAlt = { fg = c.fg, bg = c.alt },
    FlnFileInfo = { fg = c.fg, bg = c.bg },
    FlnAltSep = { fg = c.bg, bg = c.alt },
    FlnGitBranch = { fg = c.magenta, bg = c.bg },
    FlnGitSeperator = { fg = c.bg, bg = c.alt },
  }
  for k, v in pairs(groups) do
    highlight(k, v)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = colors.gen_highlights })

return colors
