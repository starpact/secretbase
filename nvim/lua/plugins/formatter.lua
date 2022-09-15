local util = require("formatter.util")

local function nixFormatter()
  return {
    exe = "nixpkgs-fmt",
  }
end

local function protoFormatter()
  return {
    exe = "buf",
    args = {
      "format",
      util.get_current_buffer_file_path(),
    },
    stdin = true,
  }
end

require("formatter").setup({
  filetype = {
    css = { require("formatter.filetypes.css").prettierd },
    nix = { nixFormatter },
    html = { require("formatter.filetypes.html").prettierd },
    proto = { protoFormatter },
    python = { require("formatter.filetypes.python").black },
    yaml = { require("formatter.filetypes.yaml").prettierd },
  }
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.css", "*.html", "*.nix", "*.proto", "*.py", "*.yaml", "*.yml" },
  command = "FormatWrite",
})
