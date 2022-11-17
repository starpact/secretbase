local lspconfig = require("lspconfig")
local util = require("tools.util")

local unconfigured_servers = {
  "bashls",
  "bufls",
  "cssls",
  "eslint",
  "html",
  "jsonls",
  "nil_ls",
  "pyright",
  "terraformls",
  "tsserver",
  "yamlls",
}
for _, server in ipairs(unconfigured_servers) do
  lspconfig[server].setup({
    capabilities = util.capabilities,
    on_attach = util.on_attach,
  })
end

require("tools.languages.c").setup_lsp()
require("tools.languages.go").setup_lsp()
require("tools.languages.java").setup_lsp()
require("tools.languages.lua").setup_lsp()
require("tools.languages.rust").setup_lsp()
require("tools.languages.toml").setup_lsp()
