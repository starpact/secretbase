vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.c", "*.cpp", ".h" },
  callback = function() vim.lsp.buf.format({ timeout_ms = 1000 }) end,
})

return {
  cmd = { "clangd", "--function-arg-placeholders=0" },
}
