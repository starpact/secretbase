require("nvim-autopairs").setup({ check_ts = true })
require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

require("nvim-surround").setup()

require("Comment").setup()

require("leap").set_default_keymaps()

require("harpoon").setup()
vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file)
vim.keymap.set("n", "<C-s>", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "gn", require("harpoon.ui").nav_next)
vim.keymap.set("n", "gp", require("harpoon.ui").nav_prev)

require("fidget").setup({
  window = {
    blend = 0,
  },
  sources = {
    jdtls = { ignore = true },
    ["null-ls"] = { ignore = true },
  },
})

vim.keymap.set("n", "<leader>w", function()
  local path = vim.fs.find({
    "build.zig",
    ".git",
    "Cargo.toml",
    "go.mod",
    "gradlew",
    "Makefile",
    "mvnw",
    "package.json",
    "requirements.txt",
  }, {
    path = vim.api.nvim_buf_get_name(0),
    upward = true,
  })[1]
  if path then
    vim.api.nvim_set_current_dir(vim.fs.dirname(path))
  end
end)
