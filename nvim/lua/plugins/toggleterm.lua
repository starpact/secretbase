local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = "<C-\\>",
  shade_terminals = false,
})

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

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
