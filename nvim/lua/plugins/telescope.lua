local telescope = require("telescope")

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.load_extension("fzf")
telescope.load_extension("projects")

local function map(keys, cmd)
  vim.keymap.set("n", keys, cmd, { noremap = true, silent = true })
end

map("<leader>f", builtin.find_files)
map("<leader>o", builtin.oldfiles)
map("<leader>b", builtin.buffers)
map("<leader>d", builtin.diagnostics)
map("<leader>/", builtin.live_grep)
map("<leader>gs", builtin.git_status)
map("<leader>gc", builtin.git_commits)
map("<leader>p", telescope.extensions.projects.projects)

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
