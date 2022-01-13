vim.cmd("autocmd BufWritePre *.c,*.cpp,*.h lua vim.lsp.buf.formatting_sync(nil, 1000)")

local ok, util = pcall(require, "lspconfig.util")
if not ok then
  return
end

local root_pattern = util.root_pattern(
  "compile_commands.json",
  "compile_flags.txt",
  ".clang-format",
  ".git"
)

return {
  cmd = { "clangd", "--function-arg-placeholders=0" },
  root_dir = function(fname)
    local filename = util.path.is_absolute(fname) and fname or util.path.join(vim.loop.cwd(), fname)
    return root_pattern(filename)
  end,
}
