local options = {
  fileencoding = "utf-8",                  -- the encoding written to a file
  swapfile = false,                        -- creates a swapfile
  backup = false,                          -- creates a backup file
  writebackup = false,                     -- if a file is being edited by another program, it is not allowed to be edited
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  autoread = true,

  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard

  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines

  conceallevel = 0,                        -- so that `` is visible in markdown files

  hlsearch = true,                         -- highlight all matches on previous search pattern
  incsearch = true,                        -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- smart case

  mouse = "a",                             -- allow the mouse to be used in neovim

  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  wrap = false,                            -- display lines as one long line
  scrolloff = 10,                          -- is one of my fav

  smartindent = true,                      -- make indenting smarter again
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- insert 4 spaces for a tab

  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window

  termguicolors = true,                    -- set term gui colors (most terminals support this)

  timeoutlen = 200,                        -- time to wait for a mapped sequence to complete (in milliseconds)
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c") vim.cmd [[
  if system('uname -r') =~ "Microsoft"
    augroup Yank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# 'y' | call system('/mnt/c/windows/system32/clip.exe ', @0)
      augroup END
  endif
]]
