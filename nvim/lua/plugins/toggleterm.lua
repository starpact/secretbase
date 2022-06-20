local function map(keys, cmd)
  vim.keymap.set("t", keys, cmd, { noremap = true })
end

function _G.set_terminal_keymaps()
  map("<Esc>", "<C-\\><C-n>")
  map("jk", "<C-\\><C-n>")
  map("<C-h>", "<C-\\><C-n><C-W>h")
  map("<C-j>", "<C-\\><C-n><C-W>j")
  map("<C-k>", "<C-\\><C-n><C-W>k")
end

require("toggleterm").setup({
  size = vim.o.lines * 0.3,
  open_mapping = "<C-t>",
  shade_terminals = false,
})

local toggleterm_pattern = "term://*#toggleterm#*"

vim.api.nvim_create_autocmd("WinEnter", {
  pattern = toggleterm_pattern,
  callback = function()
    local terms = require("toggleterm.terminal")
    local _, term = terms.identify()
    if term then
      term:set_mode(terms.mode.INSERT)
    end
  end
})

vim.cmd(string.format("autocmd! TermOpen %s lua set_terminal_keymaps()", toggleterm_pattern))
