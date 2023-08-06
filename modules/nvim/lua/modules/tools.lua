do
  local null_ls = require("null-ls")
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
      null_ls.builtins.formatting.terraform_fmt,
      -- linters
      null_ls.builtins.diagnostics.cue_fmt,
      null_ls.builtins.diagnostics.codespell.with({
        extra_args = { "-L", "crate,flate,inout,ot,ser,te,wit" },
      }),
      null_ls.builtins.diagnostics.terraform_validate,
    },
  })
end

do
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

  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
      lint.try_lint()
    end,
  })
end

do
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
    "*.cue", -- cue_fmt
    "*.css", -- prettier
    "*.go", -- goimports
    "*.java", -- google_java_format
    "*.lua", -- stylua
    "*.nix", -- nixpkgs_fmt
    "*.py", -- black
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
  -- "*.tf", -- terraform fmt
  vim.keymap.set("n", "<leader><leader>f", vim.lsp.buf.format)
end
