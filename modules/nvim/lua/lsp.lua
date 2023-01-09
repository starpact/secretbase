local lspconfig = require("lspconfig")
local default = require("languages.default")

local server_configs = {
  bashls = {},
  bufls = {},
  clangd = require("languages.c").lsp_config,
  cssls = {},
  eslint = {},
  gopls = {},
  html = {},
  jsonls = {},
  nil_ls = {},
  pyright = {},
  rust_analyzer = require("languages.rust").lsp_config,
  sumneko_lua = require("languages.lua").lsp_config,
  taplo = {},
  terraformls = {},
  tsserver = {},
  yamlls = {},
  zls = {},
}
for server, config in pairs(server_configs) do
  lspconfig[server].setup(vim.tbl_deep_extend("keep", config, {
    capabilities = default.capabilities,
    on_attach = default.on_attach,
  }))
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
