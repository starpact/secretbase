vim.loader.enable()

vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.fileencoding = "UTF-8"
vim.o.foldlevelstart = 99
vim.o.foldmethod = "indent"
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.jumpoptions = "stack"
vim.o.number = true
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.scrolloff = 3
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.wrap = false

require("modules.colorscheme")
require("modules.keymaps")
require("modules.search")
require("modules.statusline")
require("modules.misc")
require("modules.tree")
require("modules.treesitter")
require("modules.test")
require("modules.lsp")
require("modules.tools")
require("modules.completion")
