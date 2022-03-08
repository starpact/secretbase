vim.cmd("autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)")

return {
  cmd = { "lua-language-server", "--preview" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
