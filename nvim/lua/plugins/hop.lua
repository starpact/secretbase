vim.keymap.set({ "n", "v" }, "<leader>j", "<cmd>HopChar2AC<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>k", "<cmd>HopChar2BC<CR>", { noremap = true, silent = true })

require("hop").setup()
