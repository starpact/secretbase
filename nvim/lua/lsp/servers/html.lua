vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.html" },
  callback = function() vim.lsp.buf.format({ timeout_ms = 1000 }) end,
})

return {}
