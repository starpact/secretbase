local lspconfig = require("lspconfig")
local util = require("tools.util")

local M = {}

M.setup_lsp = function()
  lspconfig.taplo.setup({
    root_dir = lspconfig.util.find_git_ancestor,
    capabilities = util.capabilities,
    on_attach = util.on_attach,
  })
end

return M
