local lspconfig = require("lspconfig")
local util = require("tools.util")

local M = {}

function M.setup_lsp()
  lspconfig.clangd.setup({
    cmd = { "clangd", "--function-arg-placeholders=0" },
    capabilities = util.capabilities,
    on_attach = util.on_attach,
  })
end

return M
