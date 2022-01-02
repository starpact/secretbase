local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

telescope.load_extension("fzf")
telescope.load_extension("projects")

local function map(keys, cmd)
  vim.api.nvim_set_keymap("n", keys, cmd, { noremap = true, silent = true })
end

map("<Leader>ff", "<cmd>Telescope find_files<CR>")
map("<Leader>fo", "<cmd>Telescope oldfiles<CR>")
map("<Leader>fb", "<cmd>Telescope buffers<CR>")
map("<Leader>fg", "<cmd>Telescope live_grep<CR>")
map("<Leader>fp", "<cmd>Telescope projects<CR>")
map("<Leader>fh", "<cmd>Telescope help_tags<CR>")

telescope.setup({
  defaults = {
    prompt_prefix = "🔭 ",
    selection_caret = " ",
    path_display = { "smart" },
  },
})
