require("formatter").setup({
  filetype = {
    python = { require("formatter.filetypes.python").yapf },
    yaml = { require("formatter.filetypes.yaml").prettier },
  }
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.py", "*.yml", "*.yaml" },
  command = "FormatWrite",
})
