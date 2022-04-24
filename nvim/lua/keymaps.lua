local function map(mod, keys, cmd)
  vim.api.nvim_set_keymap(mod, keys, cmd, { noremap = true, silent = true })
end

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "

map("i", "jk", "<Esc>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<C-u>", "10k")
map("n", "<C-d>", "10j")
map("v", "<C-u>", "10k")
map("v", "<C-d>", "10j")

map("n", "<M-Left>", "<cmd>vertical resize -5<CR>")
map("n", "<M-Down>", "<cmd>resize +5<CR>")
map("n", "<M-Up>", "<cmd>resize -5<CR>")
map("n", "<M-Right>", "<cmd>vertical resize +5<CR>")

map("n", "<leader>h", "<cmd>noh<CR>")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("t", "<C-h>", "<C-\\><C-N><C-w>h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k")
