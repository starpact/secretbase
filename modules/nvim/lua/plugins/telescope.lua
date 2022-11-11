local telescope = require("telescope")

telescope.load_extension("fzf")
telescope.load_extension("projects")

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local themes = require("telescope.themes")

local function projects()
  telescope.extensions.projects.projects(themes.get_ivy())
end

local function default_pickers(opts)
  opts = opts or {}
  return vim.tbl_deep_extend("force", { theme = "ivy" }, opts)
end

local function lsp_picker(opts)
  opts = opts or {}
  return vim.tbl_deep_extend("force",
    {
      theme = "ivy",
      initial_mode = "normal",
      path_display = { "tail" },
      fname_width = 30,
      trim_text = true,
    },
    opts
  )
end

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    dynamic_preview_title = true,
    results_title = "",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
      },
      n = {
        ["o"] = actions.select_default,
        ["q"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = default_pickers(),
    oldfiles = default_pickers(),
    live_grep = default_pickers(),
    git_status = default_pickers(),
    git_commits = default_pickers(),
    commands = default_pickers(),
    command_history = default_pickers(),

    diagnostics = lsp_picker(),
    lsp_definitions = lsp_picker(),
    lsp_declarations = lsp_picker(),
    lsp_type_definitions = lsp_picker(),
    lsp_references = lsp_picker({ include_current_line = true }),
    lsp_implementations = lsp_picker(),
  },
})

vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>o", builtin.oldfiles)
vim.keymap.set("n", "<leader>/", builtin.live_grep)
vim.keymap.set("n", "<leader>dl", builtin.diagnostics)
vim.keymap.set("n", "<leader>gs", builtin.git_status)
vim.keymap.set("n", "<leader>gc", builtin.git_commits)
vim.keymap.set("n", "<leader>cl", builtin.commands)
vim.keymap.set("n", "<leader>ch", builtin.command_history)
vim.keymap.set("n", "<leader>p", projects)
