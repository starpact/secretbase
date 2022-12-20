require("project_nvim").setup({
  manual_mode = true,
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

vim.keymap.set("n", "<leader>w", "<cmd>ProjectRoot<CR>")
