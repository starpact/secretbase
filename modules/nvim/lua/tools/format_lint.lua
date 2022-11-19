local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    formatting.black,
    formatting.buf,
    formatting.cue_fmt,
    formatting.google_java_format,
    formatting.nixpkgs_fmt,
    formatting.prettier.with({ filetypes = { "css", "yaml" } }),
    formatting.shfmt,
    formatting.sql_formatter,
    formatting.stylua,

    diagnostics.clang_check,
    diagnostics.cppcheck,
    diagnostics.cue_fmt,
    diagnostics.flake8,
    diagnostics.golangci_lint,
    diagnostics.shellcheck,
    require("tools.languages.any").linter,
    require("tools.languages.java").linter,
  },
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
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
  },
  callback = function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= "null-ls"
      end,
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {
    "*.cue", -- cue_fmt
    "*.css", -- prettier
    "*.java", -- google_java_format
    "*.lua", -- stylua
    "*.nix", -- nixpkgs_fmt
    "*.proto", -- buf
    "*.py", -- black
    "*.sh", -- shfmt
    "*.yaml", -- prettier
    "*.yml", -- prettier
  },
  callback = function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "null-ls"
      end,
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*.go",
  callback = require("tools.languages.go").format,
})
