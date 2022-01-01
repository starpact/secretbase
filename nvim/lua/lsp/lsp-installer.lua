local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local configured_servers = {
  sumneko_lua = true,
}

lsp_installer.on_server_ready(function(server)
  local handlers = require("lsp.handlers")
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  if configured_servers[server.name] then
    opts = vim.tbl_deep_extend(
      "force",
      require("lsp.settings." .. server.name),
      opts
    )
  end

  server:setup(opts)
end)
