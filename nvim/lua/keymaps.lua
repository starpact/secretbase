local map = function(mod, keys, cmd)
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

map("n", "<M-Up>", ":resize -2<CR>")
map("n", "<M-Down>", ":resize +2<CR>")
map("n", "<M-Left>", ":vertical resize -2<CR>")
map("n", "<M-Right>", ":vertical resize +2<CR>")

map("n", "<leader>h", ":noh<CR>")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("t", "<C-h>", "<C-\\><C-N><C-w>h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k")
-- <C-l> is used too often in the terminal so I do not map that. As a result,
-- there should be no window on the right side of the terminal.
