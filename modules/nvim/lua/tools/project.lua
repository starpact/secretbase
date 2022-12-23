local function cd_root()
  local dir = vim.fs.dirname(vim.fs.find({
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
  })[1])
  if dir then
    vim.api.nvim_set_current_dir(dir)
  end
end

vim.keymap.set("n", "<leader>w", cd_root)
