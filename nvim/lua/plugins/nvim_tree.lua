local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
  },
}
vim.g.nvim_tree_indent_markers = 1

local function map(mod, keys, cmd)
  vim.api.nvim_set_keymap(mod, keys, cmd, { noremap = true, silent = true })
end

map("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>")

nvim_tree.setup({
  update_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  system_open = {
    cmd = "code", -- vscode
  },
})
