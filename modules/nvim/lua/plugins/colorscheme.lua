vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_visual = "reverse"

vim.cmd.colorscheme("gruvbox-material")

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("VirtualTextError", { ctermfg = 167, fg = "#c14a4a" })
hl("VirtualTextWarning", { ctermfg = 214, fg = "#b47109" })
hl("VirtualTextInfo", { ctermfg = 109, fg = "#45707a" })
hl("VirtualTextHint", { ctermfg = 142, fg = "#6c782e" })

hl("@field", { link = "Fg" })
hl("@namespace", { link = "Fg" })
hl("@property", { link = "Fg" })
hl("@type.qualifier", { link = "Red" })
hl("@storageclass", { link = "Red" })
hl("@type.definition", { link = "Yellow" })
