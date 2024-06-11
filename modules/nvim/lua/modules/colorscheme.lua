vim.o.background = "light"

vim.api.nvim_set_hl(0, "@property", { link = "@variable" })
vim.api.nvim_set_hl(0, "@module", { link = "@variable" })
vim.api.nvim_set_hl(0, "Type", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#787878" })

vim.api.nvim_set_hl(0, "StatusLine", { fg = "NvimDarkGrey1", bg = "NvimLightGrey3" })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "NvimDarkGrey4", bg = "NvimLightGrey3" })
vim.api.nvim_set_hl(0, "StatusLineError", { fg = "NvimDarkRed", bg = "NvimLightGrey3" })
vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = "NvimDarkYellow", bg = "NvimLightGrey3" })
vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = "NvimDarkCyan", bg = "NvimLightGrey3" })
vim.api.nvim_set_hl(0, "StatusLineHint", { fg = "NvimDarkBlue", bg = "NvimLightGrey3" })

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
