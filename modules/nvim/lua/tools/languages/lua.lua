local lspconfig = require("lspconfig")
local common = require("tools.common")

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
    capabilities = common.capabilities,
    on_attach = common.on_attach,
    settings = settings,
  })
end

return M
