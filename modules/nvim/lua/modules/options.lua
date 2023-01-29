for k, v in pairs({
  fileencoding = "UTF-8",
  swapfile = false,
  backup = false,
  undofile = true,
  clipboard = "unnamedplus",
  number = true,
  relativenumber = true,
  scrolloff = 3,
  jumpoptions = "stack",
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  signcolumn = "yes",
  pumheight = 10,
  showmode = false,
  wrap = false,
  termguicolors = true,
  foldmethod = "indent",
  foldlevelstart = 99,
  laststatus = 3,
}) do
  vim.opt[k] = v
end

for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = "", texthl = hl })
end

vim.diagnostic.config({
  severity_sort = true,
  float = { source = "always" },
})

vim.api.nvim_create_autocmd("CursorMoved", { command = "echo" })
