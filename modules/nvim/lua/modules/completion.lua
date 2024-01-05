local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-y>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
  },
})

vim.keymap.set("i", vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true), function()
  cmp.complete({ config = { sources = { { name = "nvim_lsp" } } } })
end)

require("snippy").setup({
  mappings = {
    is = {
      ["<Tab>"] = "expand_or_advance",
      ["<S-Tab>"] = "previous",
    },
  },
})
