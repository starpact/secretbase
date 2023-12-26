local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.buf,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.formatting.nixpkgs_fmt,
    null_ls.builtins.formatting.prettier.with({ filetypes = { "css", "yaml" } }),
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.sql_formatter,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.terraform_fmt,
  },
})

local function format_on_save(use_null_ls, pattern)
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = pattern,
    callback = function()
      vim.lsp.buf.format({
        filter = function(client)
          return (client.name == "null-ls") == use_null_ls
        end,
      })
    end,
  })
end

format_on_save(true, {
  "*.css", -- prettier
  "*.go", -- goimports
  "*.java", -- google_java_format
  "*.lua", -- stylua
  "*.nix", -- nixpkgs_fmt
  "*.py", -- black
  "*.tf", -- terraform fmt
  "*.yaml", -- prettier
  "*.yml", -- prettier
})

format_on_save(false, {
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
})

-- Manually format.
-- "*.proto", -- buf
-- "*.sh", -- shfmt
-- "*.sql", -- sql-formatter
vim.keymap.set("n", "<A-F>", vim.lsp.buf.format)
