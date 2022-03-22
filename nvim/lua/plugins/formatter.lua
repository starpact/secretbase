local ok, formatter = pcall(require, "formatter")
if not ok then
  return
end

formatter.setup({
  filetype = {
    python = {
      function()
        return {
          exe = "black",
          args = { "-" },
          stdin = true,
        }
      end
    },
  }
})

vim.api.nvim_exec([[
augroup AutoFormatGroup
  autocmd!
  autocmd BufWritePost *.py FormatWrite
augroup END
]], true)
