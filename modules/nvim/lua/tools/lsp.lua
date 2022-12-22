local lspconfig = require("lspconfig")
local common = require("tools.common")

local servers_default = {
  "bashls",
  "bufls",
  "cssls",
  "eslint",
  "html",
  "jsonls",
  "nil_ls",
  "pyright",
  "taplo",
  "terraformls",
  "tsserver",
  "yamlls",
  "zls",
}
for _, server in ipairs(servers_default) do
  lspconfig[server].setup({
    capabilities = common.capabilities,
    on_attach = common.on_attach,
  })
end

require("tools.languages.c").setup_lsp()
require("tools.languages.go").setup_lsp()
require("tools.languages.java").setup_lsp()
require("tools.languages.lua").setup_lsp()
require("tools.languages.rust").setup_lsp()
