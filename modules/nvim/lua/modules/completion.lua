local cmp = require("cmp")
local snippy = require("snippy")

cmp.setup({
  sources = { { name = "snippy" } },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-y>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif snippy.can_jump(1) then
        snippy.next()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if snippy.can_jump(-1) then snippy.previous() end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
  },
})

vim.keymap.set("i", vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true), function()
  cmp.complete({ config = { sources = { { name = "nvim_lsp" } } } })
  cmp.select_next_item()
end)
