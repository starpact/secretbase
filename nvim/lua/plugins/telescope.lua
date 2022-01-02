local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

telescope.load_extension("fzf")
telescope.load_extension("projects")

local function map(keys, cmd)
  vim.api.nvim_set_keymap("n", keys, cmd, { noremap = true, silent = true })
end

map("<leader>f", "<cmd>Telescope find_files<CR>")
map("<leader>o", "<cmd>Telescope oldfiles<CR>")
map("<leader>b", "<cmd>Telescope buffers<CR>")
map("<leader>/", "<cmd>Telescope live_grep<CR>")
map("<leader>tp", "<cmd>Telescope projects<CR>")
map("<leader>th", "<cmd>Telescope help_tags<CR>")

telescope.setup({
  defaults = {
    prompt_prefix = "🔭 ",
    selection_caret = " ",
    path_display = { "smart" },
  },
})
