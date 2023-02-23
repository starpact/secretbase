vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_transparent_background = 1
vim.cmd.colorscheme("gruvbox-material")

vim.api.nvim_set_hl(0, "Statusline", { link = "FloatBorder" })

vim.api.nvim_set_hl(0, "VirtualTextError", { fg = "#e67e80" })
vim.api.nvim_set_hl(0, "VirtualTextWarning", { fg = "#dbbc7f" })
vim.api.nvim_set_hl(0, "VirtualTextInfo", { fg = "#7fbbb3" })
vim.api.nvim_set_hl(0, "VirtualTextHint", { fg = "#a7c080" })

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
