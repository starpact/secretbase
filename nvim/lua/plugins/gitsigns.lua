local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

local function map(keys, cmd)
  vim.api.nvim_set_keymap("n", keys, cmd, { noremap = true, silent = true })
end

map("<leader>gh", "<cmd>Gitsigns preview_hunk<CR>")

gitsigns.setup({
  keymaps = {
    noremap = false,
  },
})
