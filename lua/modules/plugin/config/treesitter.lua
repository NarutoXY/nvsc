local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main",
    -- branch = "attached-modifiers",
  },
}

parser_configs.norg_table = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
    files = { "src/parser.c" },
    branch = "main",
  },
}

parser_configs.norg_meta = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
    branch = "main",
    files = { "src/parser.c" },
  },
}
--
require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    custom_captures = {
      ["require_call"] = "RequireCall",
      ["function_definition"] = "FunctionDefinition",
    },
  },
  incremental_selection = {
    enable = true,

    keymaps = {
      init_selection = "gnn",
      node_incremental = "gnn",
      scope_incremental = "gns",
      node_decremental = "gnp",
    },
  },
})
