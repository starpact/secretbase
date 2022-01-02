vim.cmd("autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 300)")

return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
