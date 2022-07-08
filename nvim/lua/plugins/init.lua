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

    -- ui enhancement
    use("stevearc/dressing.nvim")

    -- colorscheme
    use("sainnhe/gruvbox-material")

    -- util
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")
    use("numToStr/Comment.nvim")
    use("tpope/vim-surround")
    use("lewis6991/gitsigns.nvim")
    use("ahmedkhalf/project.nvim")
    use("ggandor/leap.nvim")

    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- lsp
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")
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

    -- telescope
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- integrated terminal
    use("akinsho/toggleterm.nvim")

    -- status line
    use("nvim-lualine/lualine.nvim")

    -- file explorer
    use("kyazdani42/nvim-tree.lua")

    -- test runner
    use("vim-test/vim-test")

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

require("plugins.dressing")
require("plugins.colorscheme")
require("plugins.autopairs")
require("plugins.autotag")
require("plugins.nvim_comment")
require("plugins.gitsigns")
require("plugins.project")
require("plugins.leap")
require("plugins.treesitter")
require("plugins.fidget")
require("plugins.formatter")
require("plugins.nvim_lint")
require("plugins.snippets")
require("plugins.nvim_cmp")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.lualine")
require("plugins.nvim_tree")
require("plugins.test")
