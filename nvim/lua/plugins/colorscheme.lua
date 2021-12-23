local colorscheme = "gruvbox-material"

vim.g.gruvbox_material_transparent_background = 1

if not pcall(vim.cmd, "colorscheme " .. colorscheme) then
    vim.notify("colorscheme " .. colorscheme .. " not found")
end
