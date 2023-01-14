vim.g["test#custom_strategies"] = {
  tmux_window = function(cmd)
    vim.fn.jobstart({ "tmux", "new-window", "-t:+1", "-d" })
    vim.fn.jobstart({ "tmux", "send-key", "-t:+1", cmd .. "\n" })
    if not vim.startswith(cmd, "cargo") then
      vim.fn.jobstart({ "tmux", "select-window", "-t:+1" })
    end
  end,
}

vim.g["test#strategy"] = "tmux_window"

vim.g["test#go#runner"] = "gotest"
vim.g["test#go#gotest#options"] = "-v -race -failfast --count=1"

vim.g["test#rust#runner"] = "cargonextest"
vim.g["test#rust#cargonextest#options"] = "--no-capture --run-ignored all"

vim.g["test#python#runner"] = "pyunit"

vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>")
vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<CR>")
