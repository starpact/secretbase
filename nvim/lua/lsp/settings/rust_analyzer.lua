vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.rs" },
  callback = function() vim.lsp.buf.formatting_sync(nil, 1000) end,
})


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
