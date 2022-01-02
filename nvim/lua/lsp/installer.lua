local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_ok_lspconfig then
  return
end

local function general_opts()
  local handlers = require("lsp.handlers")
  return {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }
end

lsp_installer.on_server_ready(function(server)
  local opts = general_opts()
  local configured, settings = pcall(require, "lsp.settings." .. server.name)
  if configured then
    opts = vim.tbl_deep_extend("force", settings, opts)
  end

  server:setup(opts)
end)

-- Some language servers not included in nvim-lsp-installer
lspconfig.golangci_lint_ls.setup(vim.tbl_deep_extend("force", require("lsp.settings.golangci_lint"), general_opts()))
