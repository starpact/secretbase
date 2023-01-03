vim.g.everforest_background = "hard"
vim.g.everforest_disable_italic_comment = 1
vim.g.everforest_transparent_background = 1
vim.cmd.colorscheme("everforest")

vim.api.nvim_set_hl(0, "VirtualTextError", { ctermfg = 167, fg = "#f85552" })
vim.api.nvim_set_hl(0, "VirtualTextWarning", { ctermfg = 214, fg = "#dfa000" })
vim.api.nvim_set_hl(0, "VirtualTextInfo", { ctermfg = 109, fg = "#3a94c5" })
vim.api.nvim_set_hl(0, "VirtualTextHint", { ctermfg = 142, fg = "#8da101" })

vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Blue" })
vim.api.nvim_set_hl(0, "@field", { link = "Fg" })
vim.api.nvim_set_hl(0, "@namespace", { link = "Fg" })
vim.api.nvim_set_hl(0, "@property", { link = "Fg" })
vim.api.nvim_set_hl(0, "@storageclass", { link = "Red" })
vim.api.nvim_set_hl(0, "@type.definition", { link = "Yellow" })
vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Red" })
vim.api.nvim_set_hl(0, "@variable.builtin", { link = "Blue" })

vim.api.nvim_set_hl(0, "@constant.builtin.go", { link = "Blue" })
vim.api.nvim_set_hl(0, "@include.go", { link = "Red" })
vim.api.nvim_set_hl(0, "@property.go", { link = "Fg" })
