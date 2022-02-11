local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    formatting.stylua,
  },
})

-- stylua
vim.cmd("autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)")
