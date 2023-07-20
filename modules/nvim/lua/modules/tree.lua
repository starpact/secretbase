-- Disable netrw.
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

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
  renderer = {
    indent_markers = {
      enable = true,
    },
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
  system_open = {
    cmd = "code",
  },
})

vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.open({ find_file = true })
end)
vim.keymap.set("n", "<C-n>", require("nvim-tree.api").tree.toggle)
