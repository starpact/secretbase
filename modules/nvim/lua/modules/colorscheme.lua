local z = require("zenbones")

vim.g.zenbones_italic_comments = false
vim.g.zenbones_transparent_background = true
vim.cmd.colorscheme("zenbones")

vim.api.nvim_set_hl(0, "Constant", { fg = z.Constant.fg.hex })
vim.api.nvim_set_hl(0, "Number", { fg = z.Number.fg.hex })
vim.api.nvim_set_hl(0, "Special", { fg = z.Special.fg.hex })
vim.api.nvim_set_hl(0, "@storageclass", { link = "@keyword" })
vim.api.nvim_set_hl(0, "@constant", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@function.macro.rust", { link = "Function" })

vim.api.nvim_set_hl(0, "StatusLineNC", { fg = z.FloatBorder.fg.hex, bg = z.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineError", { fg = z.DiagnosticError.fg.hex, bg = z.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = z.DiagnosticWarn.fg.hex, bg = z.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = z.DiagnosticInfo.fg.hex, bg = z.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineHint", { fg = z.DiagnosticHint.fg.hex, bg = z.StatusLine.bg.hex })
