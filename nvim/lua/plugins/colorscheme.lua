vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_sign_column_background = "none"
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_visual = "reverse"

vim.cmd("colorscheme gruvbox-material")

vim.cmd([[
highlight VirtualTextError ctermfg=167 guifg=#c14a4a
highlight VirtualTextWarning ctermfg=214 guifg=#b47109
highlight VirtualTextInfo ctermfg=109 guifg=#45707a
highlight VirtualTextHint ctermfg=142 guifg=#6c782e
]])

vim.cmd([[
highlight link TSField Fg
highlight link TSNamespace Fg
]])

vim.cmd([[
highlight link NvimTreeFolderIcon Blue
]])

vim.cmd([[
highlight link FidgetTask Comment
]])

vim.cmd([[
highlight Search ctermfg=235 ctermbg=167 guifg=#282828 guibg=#ea6962
]])
