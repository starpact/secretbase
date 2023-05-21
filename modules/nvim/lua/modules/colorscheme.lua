local lush = require("lush")
local hsluv = lush.hsluv

local palette = {
  bg = hsluv("#1d1c19"),
  fg = hsluv("#c5c9c5"),
  rose = hsluv("#c4746e"),
  leaf = hsluv("#8a9a7b"),
  wood = hsluv("#c4b28a"),
  water = hsluv("#8ba4b0"),
  blossom = hsluv("#a292a3"),
  sky = hsluv("#8ea4a2"),
}

local base_specs = require("zenbones.specs").generate(palette, "dark", {
  transparent_background = true,
  italic_comments = false,
})
local specs = lush.extends({ base_specs }).with(function()
  ---@diagnostic disable: undefined-global
  return {
    Statement({ fg = palette.rose }),
    Function({ fg = palette.leaf }),
    Type({ fg = palette.wood }),
    Number({ fg = palette.water }),
    String({ fg = palette.water }),
    Special({ fg = palette.blossom }),
  }
  ---@diagnostic enable: undefined-global
end)

lush(specs)

vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticUnderlineWarn" })
vim.api.nvim_set_hl(0, "Constant", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
vim.api.nvim_set_hl(0, "@string", { link = "String" })
vim.api.nvim_set_hl(0, "@namespace", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@function.macro", { link = "Function" })
vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })
vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
vim.api.nvim_set_hl(0, "@storageclass", { link = "Statement" })
vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Statement" })

vim.api.nvim_set_hl(0, "StatusLineNC", { fg = specs.FloatBorder.fg.hex, bg = specs.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineError", { fg = specs.DiagnosticError.fg.hex, bg = specs.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = specs.DiagnosticWarn.fg.hex, bg = specs.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = specs.DiagnosticInfo.fg.hex, bg = specs.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineHint", { fg = specs.DiagnosticHint.fg.hex, bg = specs.StatusLine.bg.hex })
