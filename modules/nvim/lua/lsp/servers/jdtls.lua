require("lsp.util").format_on_save({ pattern = { "*.java" } })

return {
  cmd = {
    "jdt-language-server",
    "-data", vim.fs.normalize("~/.cache/jdtls/workspace"),
  }
}
