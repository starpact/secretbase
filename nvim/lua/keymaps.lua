local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

map("i", "jk", "<Esc>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<C-u>", "10k", opts)
map("n", "<C-d>", "10j", opts)

map("n", "<M-Up>", ":resize -2<CR>", opts)
map("n", "<M-Down>", ":resize +2<CR>", opts)
map("n", "<M-Left>", ":vertical resize -2<CR>", opts)
map("n", "<M-Right>", ":vertical resize +2<CR>", opts)

map("n", "<leader>h", ":noh<CR>", opts)

-- disable the default `swap` behavior when pasting to selected
map("v", "p", '"_dP', opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
-- <C-l> is used too often in the terminal so I do not map that. As a result,
-- there should be no window on the right side of the terminal.
