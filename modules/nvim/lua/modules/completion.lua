vim.opt.completeopt = { "menu" }
vim.opt.shortmess:append("c")

local function has_words_before()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function feedkey(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

vim.keymap.set({ "i", "s" }, "<Tab>", function()
  feedkey(has_words_before() and "<C-x><C-o>" or "<Tab>")
end)

local snippy = require("snippy")

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if snippy.can_expand_or_advance() then snippy.expand_or_advance() end
end)

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if snippy.can_jump(-1) then
    snippy.previous()
  else
    feedkey("<C-h>")
  end
end)
