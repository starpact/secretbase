require("packer").startup({
  function(use)
    use("ggandor/leap.nvim")
    use("SmiteshP/nvim-navic")
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})

require("plugins.colorscheme")
require("plugins.lualine")
require("plugins.dressing")
require("plugins.nvim_tree")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.treesitter")
require("plugins.fidget")
require("plugins.nvim_lint")
require("plugins.formatter")
require("plugins.snippets")
require("plugins.nvim_cmp")
require("plugins.test")
require("plugins.autopairs")
require("plugins.autotag")
require("plugins.nvim_surround")
require("plugins.nvim_comment")
require("plugins.gitsigns")
require("plugins.project")
require("plugins.dap")
require("plugins.leap")
require("plugins.navic")
