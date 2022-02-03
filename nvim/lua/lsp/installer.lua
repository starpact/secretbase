local ok_installer, installer = pcall(require, "nvim-lsp-installer")
if not ok_installer then
  return
end

local function general_opts()
  local handlers = require("lsp.handlers")
  return {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }
end

-- This function will be called for every language servers installed by nvim-lsp-installer.
installer.on_server_ready(function(server)
  local opts = general_opts()
  local configured, settings = pcall(require, "lsp.settings." .. server.name)
  if configured then
    opts = vim.tbl_deep_extend("force", settings, opts)
  end

  server:setup(opts)
end)
