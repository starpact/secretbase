-- Set tabsize.
vim.cmd([[
autocmd BufRead,BufNewFile *.json,*.yml,*.yaml,*.toml,*.lua,*html,*css,*.js,*.jsx,*.ts,*.tsx setlocal ts=2 sw=2
autocmd BufRead,BufNewFile *.go setlocal expandtab!
]])

-- NvimTree auto close.
vim.cmd([[
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])

-- WSL.
vim.cmd([[
if has('wsl')
  augroup Yank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system('/mnt/c/windows/system32/clip.exe ', @0)
    augroup END
endif
]])
