local telescope = require("telescope")

telescope.load_extension("fzf")
telescope.load_extension("projects")

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>o", builtin.oldfiles)
vim.keymap.set("n", "<leader>/", builtin.live_grep)
vim.keymap.set("n", "<leader>dl", builtin.diagnostics)
vim.keymap.set("n", "<leader>gs", builtin.git_status)
vim.keymap.set("n", "<leader>gc", builtin.git_commits)
vim.keymap.set("n", "<leader>cl", builtin.commands)
vim.keymap.set("n", "<leader>ch", builtin.command_history)
vim.keymap.set("n", "<leader>p", telescope.extensions.projects.projects)

local function lsp_picker(opts)
  return vim.tbl_deep_extend("force", {
    theme = "ivy",
    initial_mode = "normal",
    path_display = { "smart" },
    mappings = {
      n = {
        ["o"] = actions.select_default,
        ["q"] = actions.close,
      },
    },
  }, opts or {})
end

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    lsp_definitions = lsp_picker(),
    lsp_declarations = lsp_picker(),
    lsp_type_definitions = lsp_picker(),
    lsp_references = lsp_picker({ include_current_line = true }),
    lsp_implementations = lsp_picker(),
    diagnostics = lsp_picker(),
  },
})
