vim.cmd("autocmd BufWritePre *.js,*jsx,*ts,*tsx lua vim.lsp.buf.formatting_sync(nil, 300)")

return {}
