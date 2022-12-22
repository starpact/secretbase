require("toggleterm").setup({
  size = vim.o.lines * 0.4,
  open_mapping = "<A-j>",
  persist_mode = true,
  shade_terminals = false,
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
end

vim.cmd(string.format("autocmd! TermOpen term://*#toggleterm#* lua set_terminal_keymaps()"))
