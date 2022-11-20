require("project_nvim").setup({
  ignore_lsp = { "null-ls" },
  patterns = {
    ".git",
    "Cargo.toml",
    "go.mod",
    "gradlew",
    "Makefile",
    "mvnw",
    "package.json",
  },
})
