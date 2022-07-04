vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.lua" },
  callback = function() vim.lsp.buf.format({ timeout_ms = 1000 }) end,
})

return {
  settings = {
    Lua = {
      format = {
        enable = true
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
