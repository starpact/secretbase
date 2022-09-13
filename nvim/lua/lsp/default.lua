local M = {}

M.on_attach = function(_, bufnr)
  local telescope = require("telescope.builtin")
  local function map(mode, key, cmd, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, key, cmd, opts)
  end

  map("n", "gd", telescope.lsp_definitions)
  map("n", "gD", vim.lsp.buf.declaration)
  map("n", "gt", telescope.lsp_type_definitions)
  map("n", "gr", telescope.lsp_references)
  map("n", "gi", telescope.lsp_implementations)
  map("n", "<leader>a", vim.lsp.buf.code_action)
  map("n", "<leader>s", telescope.lsp_document_symbols)
  map("n", "<leader>w", telescope.lsp_dynamic_workspace_symbols)
  map("n", "K", vim.lsp.buf.hover)
  map("i", "<C-k>", vim.lsp.buf.signature_help)
  map("n", "<leader>r", vim.lsp.buf.rename)
end

M.capabilities = require("cmp_nvim_lsp").update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

return M
