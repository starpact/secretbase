vim.cmd("autocmd BufWritePre *.c,*.cpp,*.h lua vim.lsp.buf.formatting_sync(nil, 1000)")

return {
  cmd = { "clangd", "--function-arg-placeholders=0" },
}
