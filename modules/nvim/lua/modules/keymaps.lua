vim.keymap.set({ "n", "x" }, "<Space>", "<Nop>")
vim.g.mapleader = " "

vim.keymap.set({ "i", "s" }, "jk", "<Esc>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set({ "n", "x" }, "<C-u>", "10k")
vim.keymap.set({ "n", "x" }, "<C-d>", "10j")

vim.keymap.set("i", "<C-n>", "<Down>")
vim.keymap.set("i", "<C-p>", "<Up>")
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-f>", "<Right>")
vim.keymap.set("i", "<C-a>", "<C-o>^")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<M-b>", "<S-Left>")
vim.keymap.set("i", "<M-f>", "<Esc>ea")

vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<M-Down>", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<M-Up>", "<cmd>resize -5<CR>")
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +5<CR>")

vim.keymap.set("n", "<leader>h", "<cmd>noh<CR>")
vim.keymap.set("n", "<leader><Tab>", "<C-^>")

vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "go", vim.diagnostic.open_float)
