vim.cmd("autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 300)")

return {}
