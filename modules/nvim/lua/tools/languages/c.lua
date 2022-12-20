local lspconfig = require("lspconfig")
local common = require("tools.common")

local M = {}

local capabilities = vim.tbl_deep_extend("force", common.capabilities, {
  offsetEncoding = { "utf-16" },
})

M.setup_lsp = function()
  lspconfig.clangd.setup({
    cmd = { "clangd", "--function-arg-placeholders=0" },
    capabilities = capabilities,
    on_attach = common.on_attach,
  })
end

return M
