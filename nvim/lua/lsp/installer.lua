local ok, installer = pcall(require, "nvim-lsp-installer")
if not ok then return end

local lspconfig
ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

installer.setup()

local handlers = require("lsp.handlers")

local servers = {
  "clangd",
  "gopls",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "taplo",
  "tsserver",
  "yamlls",
}

for _, server in ipairs(servers) do
  local configured, settings = pcall(require, "lsp.settings." .. server)
  if configured then
    lspconfig[server].setup(
      vim.tbl_deep_extend("force", settings, {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
      })
    )
  end
end
