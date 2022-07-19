vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_sign_column_background = "none"
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_visual = "reverse"

vim.cmd("colorscheme gruvbox-material")

vim.api.nvim_set_hl(0, "VirtualTextError", { ctermfg = 167, fg = "#c14a4a" })
vim.api.nvim_set_hl(0, "VirtualTextWarning", { ctermfg = 214, fg = "#b47109" })
vim.api.nvim_set_hl(0, "VirtualTextInfo", { ctermfg = 109, fg = "#45707a" })
vim.api.nvim_set_hl(0, "VirtualTextHint", { ctermfg = 142, fg = "#6c782e" })
vim.api.nvim_set_hl(0, "TSField", { link = "Fg" })
vim.api.nvim_set_hl(0, "TSNamespace", { link = "Fg" })
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { link = "Blue" })
vim.api.nvim_set_hl(0, "FidgetTask", { link = "Comment" })
vim.api.nvim_set_hl(0, "Search", { ctermfg = 235, ctermbg = 167, fg = "#282828", bg = "#ea6962" })
