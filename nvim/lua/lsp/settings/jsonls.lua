vim.cmd("autocmd BufWritePre *.json lua vim.lsp.buf.formatting_sync(nil, 1000)")

return {}
