local null_ls = require("null-ls")

null_ls.setup({
  sources = {
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

    null_ls.builtins.diagnostics.cue_fmt,
    require("tools.languages.any").linter,
  },
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

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.cue", -- cue_fmt
    "*.css", -- prettier
    "*.go", -- goimports
    "*.java", -- google_java_format
    "*.lua", -- stylua
    "*.nix", -- nixpkgs_fmt
    "*.proto", -- buf
    "*.py", -- black
    -- "*.sh", -- shfmt
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

-- cue is recognized as conf now.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.cue",
  command = "set filetype=cue",
})
