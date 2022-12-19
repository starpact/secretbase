local telescope = require("telescope")
telescope.load_extension("fzf")

telescope.load_extension("projects")
local extensions = telescope.extensions

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

vim.keymap.set("n", "<leader>p", extensions.projects.projects)
vim.keymap.set("n", "<leader>w", "<cmd>ProjectRoot<CR>")
