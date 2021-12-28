local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
  },
})

local map = function(keys, cmd)
  vim.api.nvim_set_keymap("n", keys, cmd, { noremap = true, silent = true })
end

map("<Leader>ff", "<cmd>Telescope find_files<CR>")
map("<Leader>fo", "<cmd>Telescope oldfiles<CR>")
map("<Leader>fb", "<cmd>Telescope buffers<CR>")
map("<Leader>fw", "<cmd>Telescope live_grep<CR>")
map("<Leader>fh", "<cmd>Telescope help_tags<CR>")
