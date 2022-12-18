local lspconfig = require("lspconfig")
local util = require("tools.util")

local M = {}

local settings = {
  Lua = {
    runtime = { version = "LuaJIT" },
    diagnostics = { globals = { "vim" } },
    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
  },
}

M.setup_lsp = function()
  lspconfig.sumneko_lua.setup({
    capabilities = util.capabilities,
    on_attach = util.on_attach,
    settings = settings,
  })
end

return M
