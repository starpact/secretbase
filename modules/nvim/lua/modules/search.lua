local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    borderchars = { "─", "", "", "", "", "", "", "" },
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 0.3,
      prompt_position = "top",
      preview_width = 0.5,
    },
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.cycle_history_next,
      },
    },
  },
})
telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>o", builtin.oldfiles)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>/", function()
  local cwd
  if vim.bo.filetype == "NvimTree" then
    local node = require("nvim-tree.api").tree.get_node_under_cursor()
    if node.type == "file" then
      cwd = node.parent.absolute_path
    elseif node.type == "directory" then
      cwd = node.absolute_path
    end
    vim.cmd("wincmd l") -- avoid open file action from nvim-tree buffer
  else
    cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  end
  builtin.live_grep({ cwd = cwd })
end)
vim.keymap.set("n", "<leader>?", builtin.live_grep)
vim.keymap.set("n", "<leader>d", function()
  builtin.diagnostics({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "<leader>D", builtin.diagnostics)
vim.keymap.set("n", "<leader>gs", builtin.git_status)
vim.keymap.set("n", "<leader>gc", builtin.git_bcommits)
vim.keymap.set("n", "<leader>l", builtin.builtin)
