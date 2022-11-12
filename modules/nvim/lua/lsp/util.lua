local M = {}

M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

local function buf_starts_with_any(prefixes)
  if not prefixes then return false end
  local filepath = vim.api.nvim_buf_get_name(0)
  for _, prefix in ipairs(prefixes) do
    if vim.startswith(filepath, vim.fs.normalize(prefix)) then
      return true
    end
  end
  return false
end

function M.get_root_dir(names, path)
  return vim.fs.dirname(vim.fs.find(names, {
    path = path,
    upward = true,
  })[1])
end

function M.get_buf_root_dir(names)
  return M.get_root_dir(names, vim.api.nvim_buf_get_name(0))
end

-- Reuse client when:
-- 1. The file belongs to std/3rd libs, e.g., /nix, ~/.cargo, ~/go.
-- 2. The file belongs to (submodules of) the same git repo.
function M.should_reuse_client_func(prefixes)
  return function(client, config)
    return client.name == config.name and
        (buf_starts_with_any(prefixes) or
            M.get_buf_root_dir(".git") == M.get_root_dir(".git", client.config.root_dir))
  end
end

function M.format_on_save(opts)
  if not opts.callback then
    opts.callback = function() vim.lsp.buf.format({ timeout_ms = 500 }) end
  end
  vim.api.nvim_create_autocmd({ "BufWritePre" }, opts)
end

return M
