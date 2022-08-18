local util = require("formatter.util")

require("formatter").setup({
  filetype = {
    python = { require("formatter.filetypes.python").black },
    yaml = { require("formatter.filetypes.yaml").prettierd },
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
  }
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.proto", "*.py", "*.yml", "*.yaml" },
  command = "FormatWrite",
})
