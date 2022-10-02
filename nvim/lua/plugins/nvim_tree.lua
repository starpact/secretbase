vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFile<CR>")
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")

require("nvim-tree").setup({
  disable_netrw = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  system_open = {
    cmd = "code",
  },
  update_focused_file = {
    enable = true,
    update_root = true
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        folder_arrow = false,
      },
    },
  },
})
