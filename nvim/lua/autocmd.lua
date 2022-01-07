vim.cmd([[
autocmd BufRead,BufNewFile *.json,*.yml,*.yaml,*.lua,*html,*css,*.js,*.jsx,*.ts,*.tsx setlocal ts=2 sw=2
autocmd BufRead,BufNewFile *.go setlocal expandtab!
]])

-- For wsl
vim.cmd([[
if system('uname -r') =~ "Microsoft"
  augroup Yank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system('/mnt/c/windows/system32/clip.exe ', @0)
    augroup END
endif
]])
