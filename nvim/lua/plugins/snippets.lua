local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

ls.add_snippets("go", {
  s(
    "ife",
    fmt("if err != nil {{\n\treturn {}, {}\n}}\n\n", {
      i(1, "nil"),
      c(2, { t("err"), t("errors.Trace(err)") })
    })
  ),
})
