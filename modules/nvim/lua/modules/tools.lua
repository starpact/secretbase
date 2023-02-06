local null_ls = require("null-ls")
local lint = require("lint")

null_ls.setup({
  sources = {
    -- formatters
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.buf,
    null_ls.builtins.formatting.cue_fmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.formatting.nixpkgs_fmt,
    null_ls.builtins.formatting.prettier.with({ filetypes = { "css", "yaml" } }),
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.sql_formatter,
    null_ls.builtins.formatting.stylua,
    -- linters
    null_ls.builtins.diagnostics.cue_fmt,
    null_ls.builtins.diagnostics.codespell.with({
      extra_args = {
        "-L",
        table.concat({
          "crate",
          "ser",
          "te",
          "wit",
        }, ","),
      },
    }),
  },
})

lint.linters_by_ft = {
  c = { "clangtidy", "cppcheck" },
  cpp = { "clangtidy", "cppcheck" },
  go = { "golangcilint" },
  java = { "checkstyle" },
  python = { "ruff" },
  yaml = { "yamllint" },
}

lint.linters.checkstyle.args = {
  "-c",
  function()
    for _, path in ipairs({ "checkstyle.xml", "scripts/google_style_check.xml" }) do
      if vim.fn.filereadable(path) == 1 then
        return path
      end
    end
    return "google_checks.xml"
  end,
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.cue", -- cue_fmt
    "*.css", -- prettier
    "*.go", -- goimports
    "*.java", -- google_java_format
    "*.lua", -- stylua
    "*.nix", -- nixpkgs_fmt
    "*.py", -- black
    "*.yaml", -- prettier
    "*.yml", -- prettier

    -- Manually format.
    -- "*.proto", -- buf
    -- "*.sh", -- shfmt
  },
  callback = function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "null-ls"
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.c",
    "*.cpp",
    "*.h",
    "*.html",
    "*.json",
    "*.js",
    "*.jsx",
    "*.ts",
    "*.tsx",
    "*.rs",
    "*.toml",
    "*.zig",
  },
  callback = function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= "null-ls"
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    lint.try_lint()
  end,
})

-- cue is recognized as conf now.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.cue",
  command = "set filetype=cue",
})
