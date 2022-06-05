vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function() vim.lsp.buf.formatting_sync(nil, 1000) end,
})

local function on_attach(client)
  require("lsp.handlers").on_attach()
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

return {
  on_attach = on_attach,
}
