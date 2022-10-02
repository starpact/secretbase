local M = {}

M.capabilities = require("cmp_nvim_lsp").update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

function M.format_on_save(opts)
  if not opts.callback then
    opts.callback = function() vim.lsp.buf.format({ timeout_ms = 500 }) end
  end
  vim.api.nvim_create_autocmd({ "BufWritePre" }, opts)
end

function M.get_root_dir(pattern)
  return vim.fs.dirname(vim.fs.find(pattern, {
    path = vim.api.nvim_buf_get_name(0),
    upward = true,
  })[1])
end

function M.buf_starts_with_any(prefixes)
  local filepath = vim.api.nvim_buf_get_name(0)
  for _, prefix in ipairs(prefixes) do
    if vim.startswith(filepath, vim.fs.normalize(prefix)) then
      return true
    end
    return false
  end
end

return M
