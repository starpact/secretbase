vim.g.everforest_background = "hard"
vim.g.everforest_disable_italic_comment = 1
vim.g.everforest_transparent_background = 1

vim.cmd.colorscheme("everforest")
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("VirtualTextError", { ctermfg = 167, fg = "#f85552" })
hl("VirtualTextWarning", { ctermfg = 214, fg = "#dfa000" })
hl("VirtualTextInfo", { ctermfg = 109, fg = "#3a94c5" })
hl("VirtualTextHint", { ctermfg = 142, fg = "#8da101" })

hl("@field", { link = "Fg" })
hl("@namespace", { link = "Fg" })
hl("@property", { link = "Fg" })
hl("@type.qualifier", { link = "Red" })
hl("@storageclass", { link = "Red" })
hl("@type.definition", { link = "Yellow" })
