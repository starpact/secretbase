local lush = require("lush")

local light = require("zenbones.palette").light
local p = {
  bg = light.bg,
  fg = light.fg,
  rose = light.rose,
  leaf = light.leaf,
  wood = light.wood,
  water = light.water,
  blossom = light.blossom,
}

local s = lush
  .extends({
    require("zenbones.specs").generate(p, "light", {
      transparent_background = true,
      italic_comments = false,
    }),
  })
  .with(function()
    return {
      ---@diagnostic disable: undefined-global
      Statement({ fg = p.rose }),
      Function({ fg = p.leaf }),
      Type({ fg = p.wood }),
      Number({ fg = p.water }),
      Constant({ fg = p.water }),
      Special({ fg = p.blossom }),
      ---@diagnostic enable: undefined-global
    }
  end)
lush(s)

vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
vim.api.nvim_set_hl(0, "@namespace", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@function.macro", { link = "Function" })
vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })
vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
vim.api.nvim_set_hl(0, "@storageclass", { link = "Statement" })
vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Statement" })

vim.api.nvim_set_hl(0, "StatusLineNC", { fg = s.FloatBorder.fg.hex, bg = s.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineError", { fg = s.DiagnosticError.fg.hex, bg = s.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = s.DiagnosticWarn.fg.hex, bg = s.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = s.DiagnosticInfo.fg.hex, bg = s.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineHint", { fg = s.DiagnosticHint.fg.hex, bg = s.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "FzfLuaBufFlagCur", { fg = p.rose.hex })
vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { fg = p.rose.hex })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticUnderlineWarn" })
