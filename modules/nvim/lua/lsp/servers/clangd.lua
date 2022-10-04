require("lsp.util").format_on_save({ pattern = { "*.c", "*.cpp", ".h" } })

return {
  cmd = { "clangd", "--function-arg-placeholders=0" },
}
