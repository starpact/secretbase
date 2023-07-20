local lush = require("lush")
local hsluv = lush.hsluv

local p = {
  bg = hsluv("#1d1c19"),
  fg = hsluv("#c5c9c5"),
  rose = hsluv("#c4746e"),
  leaf = hsluv("#8a9a7b"),
  wood = hsluv("#c4b28a"),
  water = hsluv("#8ba4b0"),
  blossom = hsluv("#a292a3"),
  sky = hsluv("#7aa89f"),
}

local s = lush
  .extends({
    require("zenbones.specs").generate(p, "dark", {
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
