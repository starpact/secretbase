local lspconfig = require("lspconfig")
local util = require("tools.util")

local M = {}

function M.setup_lsp()
  lspconfig.taplo.setup({
    root_dir = function()
      return util.get_buf_root_dir(".git")
    end,
    capabilities = util.capabilities,
    on_attach = util.on_attach,
  })
end

return M
