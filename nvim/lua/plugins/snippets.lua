local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
  s("ife", fmt("if err != nil {{\n\treturn {}{}\n}}\n\n", {
    c(1, { i(nil, "nil, "), i(nil, "") }),
    c(2, { i(nil, "err"), i(nil, "errors.Trace(err)") })
  })),
  s("fp", fmt("fmt.Println({})", { i(1, "") })),
})
