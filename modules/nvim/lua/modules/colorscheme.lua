vim.o.background = "dark"

vim.api.nvim_set_hl(0, "@property", { link = "@variable" })
vim.api.nvim_set_hl(0, "@module", { link = "@variable" })
vim.api.nvim_set_hl(0, "Type", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NvimDarkGrey3" })
vim.api.nvim_set_hl(0, "StatusLine", { fg = "NvimLightGrey1", bg = "NvimDarkGrey3" })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "NvimLightGrey4", bg = "NvimDarkGrey3" })
vim.api.nvim_set_hl(0, "StatusLineError", { fg = "NvimLightRed", bg = "NvimDarkGrey3" })
vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = "NvimLightYellow", bg = "NvimDarkGrey3" })
vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = "NvimLightCyan", bg = "NvimDarkGrey3" })
vim.api.nvim_set_hl(0, "StatusLineHint", { fg = "NvimLightBlue", bg = "NvimDarkGrey3" })

vim.api.nvim_set_hl(0, "FzfLuaBufFlagCur", { fg = "NvimLightRed" })
vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { fg = "NvimLightRed" })
vim.api.nvim_set_hl(0, "FzfLuaLiveSym", { fg = "NvimLightRed" })
vim.api.nvim_set_hl(0, "FzfLuaHeaderBind", { fg = "NvimLightYellow" })
vim.api.nvim_set_hl(0, "FzfLuaTabMarker", { fg = "NvimLightYellow" })
vim.api.nvim_set_hl(0, "FzfLuaBufNr", { fg = "NvimLightYellow" })

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
