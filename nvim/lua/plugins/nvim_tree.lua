local function map(mod, keys, cmd)
  vim.keymap.set(mod, keys, cmd, { noremap = true, silent = true })
end

map("n", "<leader>e", "<cmd>NvimTreeFindFile<CR>")
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")

require("nvim-tree").setup({
  disable_netrw = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  system_open = {
    cmd = "code",
  },
  view = {
    adaptive_size = true,
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
