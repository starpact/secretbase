local cmp = require("cmp")
local types = require("cmp.types")
local snippy = require("snippy")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "snippy" },
    { name = "buffer", keyword_length = 3 },
    { name = "path" },
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  preselect = cmp.PreselectMode.None,
  confirmation = {
    default_behavior = types.cmp.ConfirmBehavior.Replace,
  },
  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        snippy = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-y>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm()
      elseif snippy.can_jump(1) then
        snippy.next()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if snippy.can_jump(-1) then
        snippy.previous()
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  },
})
