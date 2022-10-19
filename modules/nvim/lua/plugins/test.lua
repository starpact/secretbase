vim.g["test#custom_strategies"] = {
  tterm = function(cmd)
    require("toggleterm").exec(cmd)
  end,
}

vim.g["test#strategy"] = "tterm"

vim.g["test#go#runner"] = "gotest"
vim.g["test#go#gotest#options"] = "-v -race -failfast --count=1"

vim.g["test#rust#runner"] = "cargonextest"
vim.g["test#rust#cargonextest#options"] = "--no-capture --run-ignored all"

vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>")
vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<CR>")
