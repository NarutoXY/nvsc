-- Map keybinds
local ok, nvim_lsp = pcall(require, "lspconfig")

if not ok then
  Log.error("nvim-lspconfig isn't available")
end

local on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<C-b>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<Leader>fs", ":lua vim.lsp.buf.formatting_sync()<CR>", opts)
end

-- Add completion capabilities (completion, snippets)
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) 

-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for more lsp servers
-- Use these servers and default configs
-- Add more servers here
local servers = CONFIG.lsp.servers or {}

local config = { on_attach = on_attach, capabilities = capabilities or vim.lsp.protocol.make_client_capabilities() }

--- Generates a config table for lspconfig
--- @return table
local function generate_sumneko_config()
  -- Configure lua language server for neovim development
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local lua_settings = {
    Lua = {
      runtime = {
        -- LuaJIT in the case of Neovim
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "P", "G" },
      },
      telemetry = { enable = false },
      workspace = {
        preloadFileSize = 180,
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  }
  local luadev = require("lua-dev").setup({
    library = {
      vimruntime = true,
      types = true,
      plugins = false,
    },
    lspconfig = lua_settings,
  })
  local _config = vim.tbl_extend("keep", config, luadev)
  _config.cmd = { "lua-language-server" }
  return _config
end

-- Start null-ls if it's in servers table
require("null-ls").setup({
  debug = true,
  sources = {
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.prettier,
    require("null-ls").builtins.code_actions.gitsigns,
  },
})

-- Setup all servers from servers tabl
for _, server in pairs(servers) do
  if server == "sumneko_lua" then
    local sumneko_config = generate_sumneko_config()
    nvim_lsp[server].setup(sumneko_config)
  elseif server == "tailwindcss" then
    nvim_lsp[server].setup({
      capabilities = capabilities,
      on_attach = function(_, bufnr)
        require("tailwindcss-colors").buf_attach(bufnr)
        on_attach(_, bufnr)
      end,
    })
  else
    nvim_lsp[server].setup(config)
  end
end

-- Change icons for Lsp Diagnostic
local signs = { Error = "", Warn = "", Info = "כֿ", Hint = "" }
for sign, icon in pairs(signs) do
  vim.fn.sign_define(
    "DiagnosticSign" .. sign,
    { text = icon, texthl = "Diagnostic" .. sign, linehl = false, numhl = "Diagnostic" .. sign }
  )
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    enable = false,
  },
})
