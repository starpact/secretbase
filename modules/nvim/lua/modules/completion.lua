vim.opt.completeopt = { "menu" }
vim.opt.shortmess:append("c")

require("snippy").setup({
  mappings = {
    is = {
      ["<Tab>"] = "expand_or_advance",
      ["<S-Tab>"] = "previous",
    },
  },
})
