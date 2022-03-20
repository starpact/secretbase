local ok, formatter = pcall(require, "formatter")
if not ok then
  return
end

local function filepath()
  return vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
end

formatter.setup({
  filetype = {
    go = {
      function()
        return {
          exe = "goimports",
          args = { "-w", filepath() },
          stdin = false,
        }
      end
    },
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
  autocmd BufWritePost *.go,*.py FormatWrite
augroup END
]], true)
