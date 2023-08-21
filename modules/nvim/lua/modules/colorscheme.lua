local lush = require("lush")
local hsluv = lush.hsluv

-- https://www.nordtheme.com/docs/colors-and-palettes
local nord = {
  [0] = hsluv("#2e3440"),
  [1] = hsluv("#3b4252"),
  [2] = hsluv("#434c5e"),
  [3] = hsluv("#4c566a"),
  [4] = hsluv("#d8dee9"),
  [5] = hsluv("#e5e9f0"),
  [6] = hsluv("#eceff4"),
  [7] = hsluv("#8fbcbb"),
  [8] = hsluv("#88c0d0"),
  [9] = hsluv("#81a1c1"),
  [10] = hsluv("#5e81ac"),
  [11] = hsluv("#bf616a"),
  [12] = hsluv("#d08770"),
  [13] = hsluv("#ebcb8b"),
  [14] = hsluv("#a3be8c"),
  [15] = hsluv("#b48ead"),
}

local p = {
  bg = nord[0],
  fg = nord[6],
  rose = nord[11],
  leaf = nord[14],
  wood = nord[13],
  water = nord[7],
  blossom = nord[15],
  sky = nord[8],
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
      Statement({ fg = nord[9] }),
      Function({ fg = nord[8] }),
      Type({ fg = nord[13] }),
      String({ fg = nord[14] }),
      Number({ fg = nord[15] }),
      Constant({ fg = nord[15] }),
      Special({ fg = nord[12] }),
      ---@diagnostic enable: undefined-global
    }
  end)
lush(s)

vim.api.nvim_set_hl(0, "@constant", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@string", { link = "String" })
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
vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { fg = p.rose.hex })
vim.api.nvim_set_hl(0, "FzfLuaHeaderBind", { fg = p.wood.hex })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticUnderlineWarn" })
vim.api.nvim_set_hl(0, "DiagnosticDeprecated", { link = "DiagnosticUnderlineWarn" })
