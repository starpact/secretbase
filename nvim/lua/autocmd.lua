vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.html", "*.css", "*.js", "*.jsx", "*.ts", "*.tsx",
    "*.lua",
    "*.json",
    "*.toml",
    "*.yml", "*.yaml",
  },
  command = "setlocal ts=2 sw=2",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.go" },
  command = "setlocal expandtab!",
})

-- WSL.
vim.cmd([[
if has('wsl')
  augroup Yank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system('/mnt/c/windows/system32/clip.exe ', @0)
    augroup END
endif
]])
