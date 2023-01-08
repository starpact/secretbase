local default = require("languages.default")

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

M.lsp_config = {
  capabilities = default.capabilities,
  on_attach = default.on_attach,
  settings = settings,
}

return M
