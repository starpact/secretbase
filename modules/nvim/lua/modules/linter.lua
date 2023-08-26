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

lint.linters.codespell.args = { "-L", "crate,flate,inout,ot,ser,te,wit" }

vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local ft = ev.match
    local ls = lint.linters_by_ft
    if not ls[ft] then
      ls[ft] = { "codespell" }
    elseif not vim.tbl_contains(ls[ft], "codespell") then
      table.insert(ls[ft], "codespell")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    lint.try_lint()
  end,
})
