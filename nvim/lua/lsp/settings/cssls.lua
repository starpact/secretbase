vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.css", "*.scss", "*.less" },
  callback = function() vim.lsp.buf.formatting_sync(nil, 1000) end,
})

return {}
