local servers = {
  "bashls",
  "clangd",
  "eslint",
  "gopls",
  "jsonls",
  "pyright",
  "rnix",
  "rust_analyzer",
  "sumneko_lua",
  "taplo",
  "tsserver",
  "yamlls",
}

local lspconfig = require("lspconfig")
local default_config = require("lsp.default")
for _, server in ipairs(servers) do
  local configured, config = pcall(require, "lsp.servers." .. server)
  if configured then
    lspconfig[server].setup(
      vim.tbl_deep_extend("keep", config, default_config)
    )
  end
end
