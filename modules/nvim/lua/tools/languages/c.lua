local lspconfig = require("lspconfig")
local util = require("tools.util")

local M = {}

local capabilities = vim.tbl_deep_extend("force", util.capabilities, {
  offsetEncoding = { "utf-16" },
})

M.setup_lsp = function()
  lspconfig.clangd.setup({
    cmd = { "clangd", "--function-arg-placeholders=0" },
    capabilities = capabilities,
    on_attach = util.on_attach,
  })
end

return M
