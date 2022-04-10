vim.cmd("autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)")

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
        postfix = {
          enable = false,
        },
      },
      workspace = {
        symbol = {
          search = {
            kind = "all_symbols",
          },
        },
      },
    },
  },
}
