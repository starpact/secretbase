local lspconfig = require("lspconfig")
local common = require("tools.common")

local M = {}

local settings = {
  ["rust-analyzer"] = {
    checkOnSave = {
      command = "clippy",
    },
    completion = {
      callable = {
        snippets = "add_parentheses",
      },
    },
    workspace = {
      symbol = {
        search = {
          kind = "all_symbols",
        },
      },
    },
  },
}

M.setup_lsp = function()
  lspconfig.rust_analyzer.setup({
    capabilities = common.capabilities,
    on_attach = common.on_attach,
    settings = settings,
  })
end

return M
