local default = require("languages.default")

local M = {}

local settings = {
  Lua = {
    diagnostics = { globals = { "vim" } },
    workspace = {
      library = { vim.fn.expand("$VIMRUNTIME/lua") },
    },
  },
}

M.lsp_config = {
  capabilities = default.capabilities,
  on_attach = default.on_attach,
  settings = settings,
}

return M
