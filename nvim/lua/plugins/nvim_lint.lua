local ok, lint = pcall(require, "lint")
if not ok then
  return
end

lint.linters_by_ft = {
  go = { "golangcilint", "codespell" },
  rust = { "codespell" },
}

lint.linters.codespell.args = {
  "-L",
  table.concat({
    "crate",
    "hist",
  }, ","),
}

vim.cmd("autocmd BufEnter,BufWritePost * lua require('lint').try_lint()")
