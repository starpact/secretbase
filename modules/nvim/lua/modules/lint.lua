local lint = require("lint")

lint.linters_by_ft = {
  c = { "clangtidy", "cppcheck" },
  cpp = { "clangtidy", "cppcheck" },
  go = { "golangcilint" },
  java = { "checkstyle" },
  python = { "ruff" },
  yaml = { "yamllint" },
}

require("modules.languages.java").update_linter(lint.linters)

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    lint.try_lint()
  end,
})
