local lint = require("lint")

lint.linters_by_ft = {
  go = { "golangcilint" },
  java = { "checkstyle" },
  proto = { "buf_lint" },
  python = { "ruff" },
  yaml = { "yamllint" },
}

lint.linters.checkstyle.args = {
  "-c",
  function()
    for _, path in ipairs({ "checkstyle.xml", "scripts/google_style_check.xml" }) do
      if vim.fn.filereadable(path) == 1 then return path end
    end
    return "google_checks.xml"
  end,
}

lint.linters.codespell.stdin = false
lint.linters.codespell.args = { "-L", "crate,flate,inout,ot,ser,statics,te,wit" }

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    lint.try_lint()
    lint.try_lint("codespell")
  end,
})
