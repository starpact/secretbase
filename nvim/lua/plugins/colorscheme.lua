local colorscheme = "gruvbox-material"

vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_sign_column_background = "none"

pcall(vim.cmd, "colorscheme " .. colorscheme)
