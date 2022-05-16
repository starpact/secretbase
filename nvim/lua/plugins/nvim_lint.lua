local ok, lint = pcall(require, "lint")
if not ok then return end

lint.linters_by_ft = {
  c = { "clangtidy", "codespell" },
  go = { "golangcilint", "codespell" },
  lua = { "codespell" },
  markdown = { "codespell" },
  python = { "flake8", "codespell" },
  rust = { "codespell" },
}

lint.linters.codespell.args = {
  "-L",
  table.concat({
    "crate",
    "hist",
  }, ","),
}

vim.api.nvim_create_autocmd({ "BufAdd", "BufWritePost" }, {
  callback = function() lint.try_lint() end
})
