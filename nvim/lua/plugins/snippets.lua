local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

require("luasnip/loaders/from_vscode").lazy_load()

ls.add_snippets("all", {
  s("curtime", f(function() return os.date("%D %H:%M") end)),
})

ls.add_snippets("go", {
  s(
    "ie",
    fmt([[
    if err != nil {{
    	return nil, err
    }}
    ]], {})
  ),
})
