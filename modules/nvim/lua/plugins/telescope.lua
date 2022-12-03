local telescope = require("telescope")

telescope.load_extension("fzf")
telescope.load_extension("projects")

local builtin = require("telescope.builtin")
local extensions = telescope.extensions
local actions = require("telescope.actions")
local themes = require("telescope.themes")
local util = require("plugins.util")

local function path_display(_, path)
  return util.path_display(path)
end

local function picker_init_normal(opts)
  return vim.tbl_deep_extend("force", {
    initial_mode = "normal",
    show_line = false,
  }, opts or {})
end

telescope.setup({
  defaults = themes.get_ivy({
    dynamic_preview_title = true,
    show_line = false,
    path_display = path_display,
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
  }),
  pickers = {
    buffers = { ignore_current_buffer = true, sort_mru = true },
    diagnostics = picker_init_normal({ no_sign = true }),
    lsp_definitions = picker_init_normal(),
    lsp_declarations = picker_init_normal(),
    lsp_type_definitions = picker_init_normal(),
    lsp_references = picker_init_normal({ jump_type = "never" }), -- FIXME: #2218
    lsp_implementations = picker_init_normal(),
  },
})

vim.keymap.set("n", "<leader>T", builtin.builtin)
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>o", builtin.oldfiles)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>/", builtin.live_grep)
vim.keymap.set("n", "<leader>?", builtin.grep_string)
vim.keymap.set("n", "<leader>d", function()
  builtin.diagnostics({ bufnr = 0 })
end)
vim.keymap.set("n", "<leader>D", builtin.diagnostics)
vim.keymap.set("n", "<leader>j", builtin.jumplist)
vim.keymap.set("n", "<leader>p", extensions.projects.projects)
