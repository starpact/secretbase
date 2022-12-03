require("nvim-tree").setup({
  disable_netrw = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  system_open = {
    cmd = "code",
  },
  git = { ignore = false },
  renderer = {
    indent_markers = {
      enable = true,
    },
    group_empty = true,
    icons = {
      git_placement = "after",
      show = {
        file = false,
        folder = false,
      },
    },
  },
  view = {
    adaptive_size = true,
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFile<CR>")
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")
