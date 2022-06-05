local function on_attach(client)
  require("lsp.handlers").on_attach()
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

return {
  on_attach = on_attach,
}
