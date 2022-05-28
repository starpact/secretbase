local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then return end


local function map(mod, keys, cmd)
  vim.keymap.set(mod, keys, cmd, { noremap = true, silent = true })
end

map("n", "<leader>e", "<cmd>NvimTreeFindFile<CR>")
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")

nvim_tree.setup({
  update_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  system_open = {
    cmd = "code", -- vscode
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
})
