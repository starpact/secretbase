local M = {}

M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  local telescope = require("telescope.builtin")
  local function map(mode, key, cmd, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, key, cmd, opts)
  end

  map("n", "gd", telescope.lsp_definitions)
  map("n", "gD", vim.lsp.buf.declaration)
  map("n", "gy", telescope.lsp_type_definitions)
  map("n", "gr", function()
    telescope.lsp_references({ include_current_line = false })
  end)
  map("n", "gi", telescope.lsp_implementations)
  map("n", "<leader>a", vim.lsp.buf.code_action)
  map("n", "<leader>s", telescope.lsp_document_symbols)
  map("n", "<leader>S", telescope.lsp_dynamic_workspace_symbols)
  map("n", "K", vim.lsp.buf.hover)
  map("i", "<C-k>", vim.lsp.buf.signature_help)
  map("n", "<leader>r", vim.lsp.buf.rename)
end

local function buf_starts_with_any(prefixes)
  if not prefixes then
    return false
  end
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
function M.reuse_client(prefixes)
  return function(client, config)
    return client.name == config.name
      and (
        buf_starts_with_any(prefixes)
        or M.get_buf_root_dir(".git") == M.get_root_dir(".git", client.config.root_dir)
      )
  end
end

return M
