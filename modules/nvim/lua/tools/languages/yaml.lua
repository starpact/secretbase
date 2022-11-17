local null_ls = require("null-ls")

local M = {}

local config = [[{
  extends: default,
  rules: {
    line-length: { max: 100 },
    document-start: disable,
    braces: { max-spaces-inside: 1 }
  }
}]]

M.linter = null_ls.builtins.diagnostics.yamllint.with({
  extra_args = {
    "--config-data=" .. config,
  },
})

return M
