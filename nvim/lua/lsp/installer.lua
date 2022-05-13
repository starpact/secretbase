local ok_installer, installer = pcall(require, "nvim-lsp-installer")
if not ok_installer then
  return
end

local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not ok_lspconfig then
  return
end

installer.setup({ automatic_installation = true })

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
