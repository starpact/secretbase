vim.o.background = "light"
local lush = require("lush")

local p = require("zenbones.palette").light
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
      Function({ fg = p.leaf }),
      Type({ fg = p.wood }),
      Number({ fg = p.water }),
      Constant({ fg = p.water }),
      String({ fg = p.water }),
      Special({ fg = p.blossom }),
      ---@diagnostic enable: undefined-global
    }
  end)
lush(s)

vim.api.nvim_set_hl(0, "@constant", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@module", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@function.macro", { link = "Function" })
vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })
vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
vim.api.nvim_set_hl(0, "Boolean", { link = "Constant" })

vim.api.nvim_set_hl(0, "StatusLineNC", { fg = s.FloatBorder.fg.hex, bg = s.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineError", { fg = s.DiagnosticError.fg.hex, bg = s.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = s.DiagnosticWarn.fg.hex, bg = s.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = s.DiagnosticInfo.fg.hex, bg = s.StatusLine.bg.hex })
vim.api.nvim_set_hl(0, "StatusLineHint", { fg = s.DiagnosticHint.fg.hex, bg = s.StatusLine.bg.hex })

vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticUnderlineWarn" })
vim.api.nvim_set_hl(0, "DiagnosticDeprecated", { link = "DiagnosticUnderlineWarn" })

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
