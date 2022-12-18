local lspconfig = require("lspconfig")
local util = require("tools.util")

local M = {}

local settings = {
  Lua = {
    diagnostics = { globals = { "vim" } },
    workspace = {
      library = { vim.fn.expand("$VIMRUNTIME/lua") },
    },
  },
}

M.setup_lsp = function()
  lspconfig.sumneko_lua.setup({
    capabilities = util.capabilities,
    on_attach = util.on_attach,
    settings = settings,
  })
end

return M
