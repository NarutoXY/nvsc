vim.cmd([[PackerLoad LuaSnip]])
vim.cmd([[PackerLoad neogen]])
vim.cmd([[PackerLoad lua-dev.nvim]])
local cmp = require("cmp")
local types = require("cmp.types")
local luasnip = require("luasnip")
local neogen = require("neogen")

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

---Returns treesitter highlights under cursor
---@return table highlights
local function get_treesitter_hl()
  local highlighter = require("vim.treesitter.highlighter")
  local ts_utils = require("nvim-treesitter.ts_utils")
  local buf = vim.api.nvim_get_current_buf()
  -- get row and column of cursor position
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- 1-based -> 0-based indexing
  row = row - 1
  -- column is different if in insert mode
  -- it's the column right of the cursor (if line) we don't want that
  if vim.api.nvim_get_mode().mode == "i" then
    col = col - 1
  end

  local self = highlighter.active[buf]
  if not self then
    return {}
  end

  local matches = {}

  self.tree:for_each_tree(function(tstree, tree)
    if not tstree then
      return
    end

    -- get root of the ast (abstract syntax tree) note that all the nodes are subnodes of the root so this isn't the top of the file
    local root = tstree:root()
    local root_start_row, _, root_end_row, _ = root:range()

    -- check if cursor_pos is inside of root
    if root_start_row > row or root_end_row < row then
      return
    end

    local query = self:get_query(tree:lang())

    if not query:query() then
      return
    end

    local iter = query:query():iter_captures(root, self.bufnr, row, row + 1)

    -- go through all the captures inside root
    for capture, node, _ in iter do
      -- get highlight of capture
      local hl = query.hl_cache[capture]

      -- check if the node is at the cursor position
      if hl and ts_utils.is_in_node_range(node, row, col) then
        local c = query._query.captures[capture] -- name of the capture in the query
        if c ~= nil then
          -- get the highlight group and insert it into the table
          local general_hl = query:_get_hl_from_capture(capture)
          table.insert(matches, general_hl)
        end
      end
    end
  end, true)
  return matches
end
local str = require("cmp.utils.str")

local kind = require("modules.plugin.lsp_kind")

luasnip.config.setup({
  region_check_events = "CursorMoved",
  delete_check_events = "TextChanged",
})

local function t(string)
  return vim.api.nvim_replace_termcodes(string, true, true, true)
end
local border = {
  "╔",
  "═",
  "╗",
  "║",
  "╝",
  "═",
  "╚",
  "║",
}

cmp.setup({
  window = {
    completion = {
      border = border,
      scrollbar = "┃",
      -- scrollbar = "║",
    },
    documentation = {
      border = border,
      -- scrollbar = "║",
      scrollbar = "┃",
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or
                    vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    return vim.fn.feedkeys(t(
                                               "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"))
                end

                vim.fn.feedkeys(t("<C-n>"), "n")
            elseif check_back_space() then
                vim.fn.feedkeys(t("<tab>"), "n")
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t("<C-p>"), "n")
            else
                fallback()
            end
        end, {"i", "s"})
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     -- cmp.select_next_item {}
    --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    --   elseif luasnip.expand_or_jumpable() then
    --     vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
    --   elseif check_backspace() then
    --     vim.fn.feedkeys(t("<Tab>"), "n")
    --   else
    --     vim.fn.feedkeys(t("<C-Space>")) -- Manual trigger
    --   end
    -- end, {
    --   "i",
    --   "s",
    --   -- "c",
    -- }),
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    --   elseif luasnip.jumpable(-1) then
    --     vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
    --   else
    --     fallback()
    --   end
    -- end, {
    --   "i",
    --   "s",
    --   -- "c",
    -- }),
  },

  sources = {
    { name = "buffer", priority = 7, keyword_length = 4 },
    { name = "path", priority = 5 },
    { name = "emoji", priority = 3 },
    { name = "greek", priority = 1 },
    { name = "calc", priority = 4 },
    { name = "nvim_lsp", priority = 9 },
    { name = "luasnip", priority = 8 },
    { name = "neorg", priority = 6 },
    { name = "latex_symbols", priority = 1 },
    { name = "nvim_lsp_signature_help", priority = 10 },
  },
  enabled = function()
    -- if require"cmp.config.context".in_treesitter_capture("comment")==true or require"cmp.config.context".in_syntax_group("Comment") then
    --   return false
    -- else
    --   return true
    -- end
    if vim.bo.ft == "TelescopePrompt" then
      return false
    end
    local lnum, col = vim.fn.line("."), math.min(vim.fn.col("."), #vim.fn.getline("."))
    for _, syn_id in ipairs(vim.fn.synstack(lnum, col)) do
      syn_id = vim.fn.synIDtrans(syn_id) -- Resolve :highlight links
      if vim.fn.synIDattr(syn_id, "name") == "Comment" then
        return false
      end
    end
    if vim.tbl_contains(get_treesitter_hl(), "TSComment") then
      return false
    end
    return true
  end,
  formatting = {
    fields = {
      cmp.ItemField.Kind,
      cmp.ItemField.Abbr,
      cmp.ItemField.Menu,
    },
    format = kind.cmp_format({
      with_text = false,
      before = function(entry, vim_item)
        -- Get the full snippet (and only keep first line)
        local word = entry:get_insert_text()
        if
          entry.completion_item.insertTextFormat
          --[[  ]]
          == types.lsp.InsertTextFormat.Snippet
        then
          word = vim.lsp.util.parse_snippet(word)
        end
        word = str.oneline(word)

        -- concatenates the string
        local max = 50
        if string.len(word) >= max then
          local before = string.sub(word, 1, math.floor((max - 3) / 2))
          word = before .. "..."
        end

        if
          entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
          and string.sub(vim_item.abbr, -1, -1) == "~"
        then
          word = word .. "~"
        end
        vim_item.abbr = word

        vim_item.dup = ({
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
        })[entry.source.name] or 0

        return vim_item
      end,
    }),
    -- format = function(entry, vim_item)
    --   vim_item.kind = string.format(
    --     "%s %s",
    --     -- "%s",
    --     get_kind(vim_item.kind),
    --     vim_item.kind
    --   )

    -- end
  },
  sorting = {
    comparators = cmp.config.compare.recently_used,
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})

cmp.setup.cmdline(":", {
  completion = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    scrollbar = "║",
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    scrollbar = "║",
  },
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  enabled = function()
    return true
  end,
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer", keyword_length = 1 },
  },
  enabled = function()
    return true
  end,
  completion = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    scrollbar = "║",
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    scrollbar = "║",
  },
})
