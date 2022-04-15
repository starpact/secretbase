local fn = vim.fn

-- Automatically install packer.
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd("packadd packer.nvim")
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- general dependency
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use("kyazdani42/nvim-web-devicons")

  -- ui enhancement
  use("stevearc/dressing.nvim")

  -- coloscheme
  use("sainnhe/gruvbox-material")

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
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")

  -- telescope
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- integrated terminal
  use("akinsho/toggleterm.nvim")

  -- utils
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
  use("numToStr/Comment.nvim")
  use("tpope/vim-surround")
  use("lewis6991/gitsigns.nvim")
  use("ahmedkhalf/project.nvim")

  -- status line
  use("nvim-lualine/lualine.nvim")

  -- file explorer
  use("kyazdani42/nvim-tree.lua")

  use("vim-test/vim-test")

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require("plugins.dressing")
require("plugins.colorscheme")
require("plugins.treesitter")
require("plugins.fidget")
require("plugins.nvim_lint")
require("plugins.formatter")
require("plugins.cmp")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.autopairs")
require("plugins.autotag")
require("plugins.comment")
require("plugins.gitsigns")
require("plugins.project")
require("plugins.lualine")
require("plugins.nvim_tree")
require("plugins.test")
