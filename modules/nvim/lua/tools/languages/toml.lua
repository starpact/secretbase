local lspconfig = require("lspconfig")
local common = require("tools.common")

local M = {}

M.setup_lsp = function()
  lspconfig.taplo.setup({
    root_dir = lspconfig.util.find_git_ancestor,
    capabilities = common.capabilities,
    on_attach = common.on_attach,
  })
end

return M
