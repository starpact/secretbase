local options = {
  fileencoding = "UTF-8",
  swapfile = false,
  backup = false,
  writebackup = false, -- if a file is being edited by another program, it is not allowed to be edited
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)

  clipboard = "unnamedplus", -- system clipboard

  number = true,
  relativenumber = true,

  hlsearch = true, -- highlight all matches on previous search pattern
  incsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  smartcase = true, -- smart case

  mouse = "a", -- allow the mouse to be used in neovim

  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  pumheight = 10, -- pop up menu height
  showmode = false,
  wrap = false,
  scrolloff = 10,

  smartindent = true, -- make indenting smarter again
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 4, -- the number of spaces inserted for each indentation
  tabstop = 4, -- insert 4 spaces for a tab

  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window

  termguicolors = true, -- set term gui colors (most terminals support this)

  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c")
