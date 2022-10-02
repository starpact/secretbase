require("lsp.util").format_on_save({ pattern = { "*.lua" }, })

return {
  settings = {
    Lua = {
      format = {
        enable = true
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
}
