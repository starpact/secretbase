local colorscheme = "gruvbox-material"

vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_sign_column_background = "none"

if not pcall(vim.cmd, "colorscheme " .. colorscheme) then
  vim.notify("colorscheme " .. colorscheme .. " not found")
end
