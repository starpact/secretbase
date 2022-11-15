local function nix_formatter()
  return {
    exe = "nixpkgs-fmt",
  }
end

local function proto_formatter()
  local filename = vim.api.nvim_buf_get_name(0)
  return {
    exe = "buf",
    args = { "format", filename },
    stdin = true,
  }
end

local function java_formatter()
  local filename = vim.api.nvim_buf_get_name(0)
  return {
    exe = "google-java-format",
    args = { filename },
    stdin = true,
  }
end

require("formatter").setup({
  filetype = {
    css = { require("formatter.filetypes.css").prettier },
    html = { require("formatter.filetypes.html").prettier },
    lua = { require("formatter.filetypes.lua").stylua },
    java = { java_formatter },
    nix = { nix_formatter },
    proto = { proto_formatter },
    python = { require("formatter.filetypes.python").black },
    sql = { require("formatter.filetypes.sql").pgformat },
    yaml = { require("formatter.filetypes.yaml").prettier },
  },
})

-- Use stand-alone formatters.
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = {
    "*.css",
    "*.html",
    "*.lua",
    "*.java",
    "*.nix",
    "*.proto",
    "*.py",
    "*.yaml",
    "*.yml",
  },
  command = "FormatWriteLock",
})

-- Use language servers.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {
    "*.c",
    "*.cpp",
    ".h",
    "*.json",
    "*.js",
    "*.jsx",
    "*.toml",
    "*.ts",
    "*.tsx",
    "*.rs",
  },
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 500 })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*.go",
  callback = require("tools.languages.go").format,
})
