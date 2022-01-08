vim.cmd("autocmd BufWritePre *.toml lua vim.lsp.buf.formatting_sync(nil, 1000)")

return {}
