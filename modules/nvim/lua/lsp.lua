local lspconfig = require("lspconfig")
local default = require("languages.default")

local server_configs = {
  bashls = nil,
  bufls = nil,
  clangd = require("languages.c").lsp_config,
  cssls = nil,
  eslint = nil,
  gopls = nil,
  html = nil,
  jsonls = nil,
  nil_ls = nil,
  pyright = nil,
  rust_analyzer = require("languages.rust").lsp_config,
  sumneko_lua = require("languages.lua").lsp_config,
  taplo = nil,
  terraformls = nil,
  tsserver = nil,
  yamlls = nil,
  zls = nil,
}
for server, config in pairs(server_configs) do
  lspconfig[server].setup(config or {
    capabilities = default.capabilities,
    on_attach = default.on_attach,
  })
end

require("languages.java").setup_lsp()

require("fidget").setup({
  window = {
    blend = 0,
  },
  sources = {
    jdtls = { ignore = true },
    ["null-ls"] = { ignore = true },
  },
})
