local fn = vim.fn

-- Automatically install packer
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

  -- coloscheme
  use("sainnhe/gruvbox-material")

  -- treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("jose-elias-alvarez/null-ls.nvim")
  use("ray-x/lsp_signature.nvim")

  -- cmp
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-nvim-lsp")

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- integrated terminal
  use("akinsho/toggleterm.nvim")

  -- utils
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
  use("numToStr/Comment.nvim")
  use("blackCauldron7/surround.nvim")
  use("lewis6991/gitsigns.nvim")
  use("ahmedkhalf/project.nvim")

  -- status line
  use("nvim-lualine/lualine.nvim")

  -- file explorer
  use("kyazdani42/nvim-tree.lua")

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require("plugins.colorscheme")
require("plugins.treesitter")
require("plugins.cmp")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.autopairs")
require("plugins.autotag")
require("plugins.comment")
require("plugins.surround")
require("plugins.gitsigns")
require("plugins.project")
require("plugins.lualine")
require("plugins.nvim_tree")
