vim.g["test#strategy"] = "neovim"

vim.g["test#go#runner"] = "gotest"
vim.g["test#go#gotest#options"] = "-v -race -failfast --count=1"

vim.g["test#rust#runner"] = "cargotest"
vim.g["test#rust#cargotest#options"] = "-- --nocapture"

vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>")
vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<CR>")
