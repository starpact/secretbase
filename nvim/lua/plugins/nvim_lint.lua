local ok, lint = pcall(require, "lint")
if not ok then
  return
end

lint.linters_by_ft = {
  c = { "codespell" },
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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = { "*.go" },
  callback = function() lint.try_lint() end,
})
