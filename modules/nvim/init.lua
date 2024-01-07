vim.loader.enable()

-- Disable netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.fileencoding = "UTF-8"
vim.o.foldlevelstart = 99
vim.o.foldmethod = "indent"
vim.o.ignorecase = true
vim.o.jumpoptions = "stack"
vim.o.number = true
vim.o.pumheight = 10
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

vim.api.nvim_create_autocmd("CursorMoved", { command = "echo" })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev)
    vim.wo.wrap = ev.file == "" or vim.endswith(ev.file, ".md")
  end,
})

require("modules.colorscheme")
require("modules.keymap")
require("modules.search")
require("modules.statusline")
require("modules.misc")
require("modules.tree")
require("modules.treesitter")
require("modules.test")
require("modules.lsp")
require("modules.formatter")
require("modules.linter")
require("modules.completion")
