vim.cmd("autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 300)")

return {
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranlarity = "crate",
      },
      checkOnSave = {
        command = "clippy",
      },
      completion = {
        addCallArgumentSnippets = false,
      },
    },
  },
}
