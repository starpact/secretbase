if not pcall(require, "lspconfig") then
  return
end

require("lsp.installer")
require("lsp.handlers").setup()
require("lsp.null_ls")
