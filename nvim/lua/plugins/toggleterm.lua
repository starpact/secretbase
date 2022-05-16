local ok, toggleterm = pcall(require, "toggleterm")
if not ok then return end

function _G.set_terminal_keymaps()
  local function map(keys, cmd)
    vim.api.nvim_buf_set_keymap(0, "t", keys, cmd, { noremap = true })
  end

  map("<Esc>", "<C-\\><C-n>")
  map("jk", "<C-\\><C-n>")
  map("<C-h>", "<C-\\><C-n><C-W>h")
  map("<C-j>", "<C-\\><C-n><C-W>j")
  map("<C-k>", "<C-\\><C-n><C-W>k")
end

toggleterm.setup({
  size = vim.o.lines * 0.3,
  open_mapping = "<C-t>",
  shade_terminals = false,
})

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
