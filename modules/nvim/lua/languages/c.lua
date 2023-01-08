local default = require("languages.default")

local M = {}

local capabilities = vim.tbl_deep_extend("force", default.capabilities, {
  offsetEncoding = { "utf-16" },
})

M.lsp_config = {
  cmd = { "clangd", "--function-arg-placeholders=0" },
  filetypes = { "c", "cpp" },
  capabilities = capabilities,
  on_attach = default.on_attach,
}

return M
