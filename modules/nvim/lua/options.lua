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
  cursorline = true,

  jumpoptions = "stack",

  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,

  mouse = "a",

  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  pumheight = 10, -- pop up menu height
  showmode = false,
  wrap = false,

  smartindent = true,
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 4, -- the number of spaces inserted for each indentation
  tabstop = 4, -- insert 4 spaces for a tab

  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window

  termguicolors = true, -- set term gui colors (most terminals support this)

  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)

  foldmethod = "indent",
  foldlevelstart = 99,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c")

-- Disable netrw.
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Diagnostics
for type, icon in pairs({ Error = "", Warn = "", Hint = "", Info = "" }) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  severity_sort = true,
  float = { source = "always" },
})