local function on_attach(client, bufnr)
  require("nvim-navic").attach(client, bufnr)

  local telescope = require("telescope.builtin")
  vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = bufnr })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
  vim.keymap.set("n", "gt", telescope.lsp_type_definitions, { buffer = bufnr })
  vim.keymap.set("n", "gr", function() telescope.lsp_references({ include_current_line = true }) end, { buffer = bufnr })
  vim.keymap.set("n", "gi", telescope.lsp_implementations, { buffer = bufnr })
  vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
  vim.keymap.set("n", "<leader>s", telescope.lsp_document_symbols, { buffer = bufnr })
  vim.keymap.set("n", "<leader>w", telescope.lsp_dynamic_workspace_symbols, { buffer = bufnr })
  vim.keymap.set("n", "<leader>d", telescope.diagnostics, { buffer = bufnr })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, { buffer = bufnr })
  vim.keymap.set("n", "gn", vim.diagnostic.goto_next, { buffer = bufnr })
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr })
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

return {
  on_attach = on_attach,
  capabilities = capabilities,
}
