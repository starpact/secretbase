local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
  s(
    "ife",
    fmt("if err != nil {{\n\treturn {}{}\n}}\n\n", {
      c(1, { i(nil, "nil, "), i(nil, "") }),
      i(2, "err"),
    })
  ),
  s("todo", t([[panic("unimplemented")]])),
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then
      ls.unlink_current()
    end
  end,
})
