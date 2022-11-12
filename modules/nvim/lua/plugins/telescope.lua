local telescope = require("telescope")

telescope.load_extension("fzf")
telescope.load_extension("projects")

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local themes = require("telescope.themes")

local function projects()
  telescope.extensions.projects.projects(themes.get_ivy())
end

local function picker_insert_mode(opts)
  return vim.tbl_deep_extend("force", {
    theme = "ivy",
    show_line = false,
  }, opts or {})
end

local function picker_normal_mode(opts)
  return vim.tbl_deep_extend("force", {
    theme = "ivy",
    initial_mode = "normal",
    show_line = false,
  }, opts or {})
end

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    dynamic_preview_title = true,
    results_title = "",
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
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
    builtin = picker_insert_mode(),
    find_files = picker_insert_mode(),
    oldfiles = picker_insert_mode(),
    buffers = picker_insert_mode({
      ignore_current_buffer = true,
      sort_mru = true,
    }),
    live_grep = picker_insert_mode(),
    git_status = picker_insert_mode(),
    git_commits = picker_insert_mode(),
    git_bcommits = picker_insert_mode(),
    commands = picker_insert_mode(),
    command_history = picker_insert_mode(),
    jumplist = picker_insert_mode(),
    lsp_document_symbols = picker_insert_mode(),
    lsp_dynamic_workspace_symbols = picker_insert_mode(),
    diagnostics = picker_normal_mode(),
    lsp_definitions = picker_normal_mode(),
    lsp_declarations = picker_normal_mode(),
    lsp_type_definitions = picker_normal_mode(),
    lsp_references = picker_normal_mode({ include_current_line = true }),
    lsp_implementations = picker_normal_mode(),
  },
})

vim.keymap.set("n", "<leader>T", builtin.builtin)
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>o", builtin.oldfiles)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>/", builtin.live_grep)
vim.keymap.set("n", "<leader>d", function() builtin.diagnostics({ bufnr = 0 }) end)
vim.keymap.set("n", "<leader>D", builtin.diagnostics)
vim.keymap.set("n", "<leader>j", builtin.jumplist)
vim.keymap.set("n", "<leader>p", projects)
