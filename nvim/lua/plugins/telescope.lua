local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local actions = require("telescope.actions")

telescope.load_extension("fzf")
telescope.load_extension("projects")

local function map(keys, cmd)
  vim.api.nvim_set_keymap("n", keys, cmd, { noremap = true, silent = true })
end

map("<leader>f", "<cmd>lua require('telescope.builtin').find_files()<CR>")
map("<leader>o", "<cmd>lua require('telescope.builtin').oldfiles({previewer=false})<CR>")
map("<leader>b", "<cmd>lua require('telescope.builtin').buffers()<CR>")
map("<leader>/", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("<leader>p", "<cmd>lua require('telescope').extensions.projects.projects()<CR>")

local function lsp_goto_picker(theme)
  return {
    theme = theme,
    initial_mode = "normal",
    path_display = { "smart" },
    mappings = {
      n = {
        ["o"] = actions.select_default,
        ["q"] = actions.close,
      },
    },
  }
end

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    layout_config = {
      preview_width = 0.5,
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    lsp_definitions = lsp_goto_picker("ivy"),
    lsp_declarations = lsp_goto_picker("ivy"),
    lsp_type_definitions = lsp_goto_picker("ivy"),
    lsp_references = lsp_goto_picker("ivy"),
    lsp_implementations = lsp_goto_picker("ivy"),
    lsp_code_actions = lsp_goto_picker("cursor"),
    diagnostics = lsp_goto_picker("ivy"),
  },
})
