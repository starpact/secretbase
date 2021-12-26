local colorscheme = "gruvbox-material"

-- vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_enable_italic = 0
vim.g.gruvbox_material_disable_italic_comment = 1

if not pcall(vim.cmd, "colorscheme " .. colorscheme) then
    vim.notify("colorscheme " .. colorscheme .. " not found")
end
