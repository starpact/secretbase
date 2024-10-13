local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    css = { "biome" },
    go = { "goimports" },
    java = { "google-java-format" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    lua = { "stylua" },
    nix = { "nixpkgs_fmt" },
    proto = { "buf" },
    python = { "ruff_format" },
    sh = { "shfmt" },
    sql = { "sql_formatter" },
    terraform = { "terraform_fmt" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    yaml = { "prettier" },
  },
  format_on_save = {
    lsp_format = "fallback",
  },
  notify_on_error = false,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.c",
    "*.cpp",
    "*.css",
    "*.go",
    "*.h",
    "*.html",
    "*.java",
    "*.js",
    "*.json",
    "*.jsonc",
    "*.jsx",
    "*.lua",
    "*.nix",
    "*.py",
    "*.rs",
    "*.tf",
    "*.toml",
    "*.ts",
    "*.tsx",
    "*.yaml",
    "*.yml",
    "*.zig",
  },
  callback = function()
    conform.format()
  end,
})

-- Manually format.
-- "*.proto", -- buf
-- "*.sh", -- shfmt
-- "*.sql", -- sql-formatter
vim.keymap.set("n", "<A-F>", conform.format)
