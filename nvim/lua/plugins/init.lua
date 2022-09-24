local fn = vim.fn

-- Automatically install packer.
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd("packadd packer.nvim")
end

local packer = require("packer")

packer.startup({
  function(use)
    use("wbthomason/packer.nvim")

    -- general dependency
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("kyazdani42/nvim-web-devicons")

    -- colorscheme
    use("sainnhe/gruvbox-material")

    -- ui enhancement
    use("stevearc/dressing.nvim")

    -- file explorer
    use("kyazdani42/nvim-tree.lua")

    -- telescope
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- integrated terminal
    use("akinsho/toggleterm.nvim")

    -- status line
    use("nvim-lualine/lualine.nvim")

    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter" })

    -- dependency
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- lsp
    use("neovim/nvim-lspconfig")
    use("j-hui/fidget.nvim")

    -- lint
    use("mfussenegger/nvim-lint")

    -- formatter
    use("mhartington/formatter.nvim")

    -- completion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("saadparwaiz1/cmp_luasnip")

    -- snippets
    use("L3MON4D3/LuaSnip")

    -- test runner
    use("vim-test/vim-test")

    -- debug
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")

    -- util
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")
    use("kylechui/nvim-surround")
    use("numToStr/Comment.nvim")
    use("lewis6991/gitsigns.nvim")
    use("ahmedkhalf/project.nvim")
    use("ggandor/leap.nvim")

    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  },
})

require("plugins.colorscheme")
require("plugins.dressing")
require("plugins.nvim_tree")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.lualine")
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
