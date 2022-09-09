local util = require("formatter.util")

require("formatter").setup({
  filetype = {
    nix = {
      function()
        return {
          exe = "nixpkgs-fmt",
        }
      end
    },
    proto = {
      function()
        return {
          exe = "buf",
          args = {
            "format",
            util.get_current_buffer_file_path(),
          },
          stdin = true,
        }
      end
    },
    python = { require("formatter.filetypes.python").black },
    yaml = { require("formatter.filetypes.yaml").prettier },
  }
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.nix", "*.proto", "*.py", "*.yml", "*.yaml" },
  command = "FormatWrite",
})
