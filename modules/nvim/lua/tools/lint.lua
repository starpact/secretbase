local lint = require("lint")

lint.linters_by_ft = {
  c = { "clangtidy" },
  cpp = { "cppcheck" },
  go = { "golangcilint" },
  java = { "checkstyle" },
  python = { "flake8" },
  yaml = { "yamllint" },
}

lint.linters.codespell.args = {
  "-L",
  table.concat({
    "crate",
    "hist",
    "ser",
  }, ","),
}

local function auto_add_codespell_linter()
  local ft = vim.bo.filetype
  local linters = lint.linters_by_ft[ft]
  if not linters then
    lint.linters_by_ft[ft] = { "codespell" }
  elseif not vim.tbl_contains(linters, "codespell") then
    table.insert(linters, "codespell")
  end
end

vim.api.nvim_create_autocmd({ "BufAdd", "BufWritePost" }, {
  callback = function()
    auto_add_codespell_linter()
    lint.try_lint()
  end,
})
