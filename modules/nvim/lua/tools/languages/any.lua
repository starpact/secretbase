local null_ls = require("null-ls")

local M = {}

M.linter = null_ls.builtins.diagnostics.codespell.with({
  extra_args = {
    "-L",
    table.concat({
      "crate",
      "ser",
      "te",
      "wit",
    }, ","),
  },
})

return M
