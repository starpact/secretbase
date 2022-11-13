local function nixFormatter()
  return {
    exe = "nixpkgs-fmt",
  }
end

local function protoFormatter()
  local filename = vim.api.nvim_buf_get_name(0)
  return {
    exe = "buf",
    args = { "format", filename },
    stdin = true,
  }
end

require("formatter").setup({
  filetype = {
    css = { require("formatter.filetypes.css").prettier },
    html = { require("formatter.filetypes.html").prettier },
    lua = { require("formatter.filetypes.lua").stylua },
    nix = { nixFormatter },
    proto = { protoFormatter },
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
    "*.nix",
    "*.proto",
    "*.py",
    "*.sql",
    "*.yaml",
    "*.yml",
  },
  command = "FormatWrite",
})

-- Use language servers.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {
    "*.c",
    "*.cpp",
    ".h",
    "*.json",
    "*.toml",
    "*.js",
    "*.jsx",
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
