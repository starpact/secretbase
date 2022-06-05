local gitsigns = require("gitsigns")

vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", { noremap = true, silent = true })

gitsigns.setup({
  keymaps = {
    noremap = false,
  },
})
