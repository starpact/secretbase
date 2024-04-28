local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    css = { "prettier" },
    go = { "goimports" },
    java = { "google-java-format" },
    lua = { "stylua" },
    nix = { "nixpkgs_fmt" },
    proto = { "buf" },
    python = { "ruff_format" },
    sh = { "shfmt" },
    sql = { "sql_formatter" },
    terraform = { "terraform_fmt" },
    yaml = { "prettier" },
  },
  notify_on_error = false,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.css",
    "*.go",
    "*.java",
    "*.lua",
    "*.nix",
    "*.py",
    "*.tf",
    "*.yaml",
    "*.yml",
  },
  callback = function()
    conform.format()
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
    "*.toml",
    "*.ts",
    "*.tsx",
    "*.rs",
    "*.zig",
  },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Manually format.
-- "*.proto", -- buf
-- "*.sh", -- shfmt
-- "*.sql", -- sql-formatter
vim.keymap.set("n", "<A-F>", conform.format)
