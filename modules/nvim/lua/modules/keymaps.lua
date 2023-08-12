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
vim.keymap.set("i", "<C-k>", "<C-o>D")
vim.keymap.set("i", "<A-b>", "<C-Left>")
vim.keymap.set("i", "<A-f>", "<Esc>ea")
vim.keymap.set("i", "<A-d>", "<C-o>de")

vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<A-Down>", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<A-Up>", "<cmd>resize -5<CR>")
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +5<CR>")

vim.keymap.set("n", "<Esc>", function()
  vim.cmd("nohlsearch")
end)

vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "go", vim.diagnostic.open_float)

vim.keymap.set("n", "cp", function()
  vim.fn.setreg("+", vim.api.nvim_buf_get_name(0) .. ":" .. vim.api.nvim_win_get_cursor(0)[1])
end)

vim.keymap.set("n", "<leader>h", function()
  local cursorword = vim.fn.expand("<cword>")
  vim.fn.setreg("/", string.format([[\<%s\>]], cursorword))
  vim.cmd("set hlsearch")
end)
