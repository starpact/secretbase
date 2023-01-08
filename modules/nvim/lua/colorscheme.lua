vim.g.everforest_disable_italic_comment = 1
vim.g.everforest_transparent_background = 1
vim.cmd.colorscheme("everforest")

vim.api.nvim_set_hl(0, "VirtualTextError", { ctermfg = 167, fg = "#f85552" })
vim.api.nvim_set_hl(0, "VirtualTextWarning", { ctermfg = 214, fg = "#dfa000" })
vim.api.nvim_set_hl(0, "VirtualTextInfo", { ctermfg = 109, fg = "#3a94c5" })
vim.api.nvim_set_hl(0, "VirtualTextHint", { ctermfg = 142, fg = "#8da101" })

vim.api.nvim_set_hl(0, "@constant.builtin.go", { link = "@constant.builtin" })
vim.api.nvim_set_hl(0, "@field", { link = "@variable" })
vim.api.nvim_set_hl(0, "@include.go", { link = "@include" })
vim.api.nvim_set_hl(0, "@include.javascript", { link = "@include" })
vim.api.nvim_set_hl(0, "@namespace", { link = "@variable" })
vim.api.nvim_set_hl(0, "@property", { link = "@variable" })
vim.api.nvim_set_hl(0, "@property.go", { link = "@property" })
vim.api.nvim_set_hl(0, "@storageclass", { link = "@keyword" })
vim.api.nvim_set_hl(0, "@type.definition", { link = "@type" })
vim.api.nvim_set_hl(0, "@type.qualifier", { link = "@keyword" })
vim.api.nvim_set_hl(0, "@variable.builtin", { link = "Blue" })
