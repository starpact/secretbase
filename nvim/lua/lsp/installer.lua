local ok_installer, installer = pcall(require, "nvim-lsp-installer")
if not ok_installer then
  return
end

local ok_config, config = pcall(require, "lspconfig")
if not ok_config then
  return
end

local function general_opts()
  local handlers = require("lsp.handlers")
  return {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }
end

installer.on_server_ready(function(server)
  local opts = general_opts()
  local configured, settings = pcall(require, "lsp.settings." .. server.name)
  if configured then
    opts = vim.tbl_deep_extend("force", settings, opts)
  end

  server:setup(opts)
end)

-- Some language servers not included in nvim-lsp-installer
config.golangci_lint_ls.setup(
  vim.tbl_deep_extend("force", require("lsp.settings.golangci_lint"), general_opts())
)
