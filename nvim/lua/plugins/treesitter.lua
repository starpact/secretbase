require("nvim-treesitter.configs").setup({
  ensure_install = { "comment" },
  auto_install = true,
  sync_install = false,
  highlight = {
    enable = true,
  },
})
