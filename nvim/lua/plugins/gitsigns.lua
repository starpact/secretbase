local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", { noremap = true, silent = true })

gitsigns.setup({
  keymaps = {
    noremap = false,
  },
})
