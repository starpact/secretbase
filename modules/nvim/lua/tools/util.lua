local M = {}

M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

M.on_attach = function(_, bufnr)
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
  map("i", "<C-s>", vim.lsp.buf.signature_help)
  map("n", "<leader>r", vim.lsp.buf.rename)
  map("n", "<leader><leader>f", vim.lsp.buf.format)
end

-- Reuse client when:
-- 1. file belongs to std/3rd libs(/nix, ~/.cargo, ~/go, etc) or
-- 2. file has the same git ancestor
M.reuse_client = function(...)
  local prefixes = vim.tbl_flatten({ ... })
  local find_git_ancestor = require("lspconfig").util.find_git_ancestor
  return function(client, config)
    if client.name ~= config.name then
      return false
    end

    local buf_name = vim.api.nvim_buf_get_name(0)
    for _, prefix in ipairs(prefixes) do
      if vim.startswith(buf_name, vim.fs.normalize(prefix)) then
        return true
      end
    end

    return find_git_ancestor(buf_name) == find_git_ancestor(client.config.root_dir)
  end
end

return M
