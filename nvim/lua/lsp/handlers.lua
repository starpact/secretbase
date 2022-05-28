local M = {}

M.setup = function()
  local signs = { Error = "", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  vim.diagnostic.config({
    severity_sort = true,
    float = { source = "always" },
  })
end

M.on_attach = function()
  local function map(mode, keys, cmd)
    vim.keymap.set(mode, keys, cmd, { noremap = true, silent = true })
  end

  local ok, telescope_builtin = pcall(require, "telescope.builtin")
  if not ok then return end

  map("n", "gd", telescope_builtin.lsp_definitions)
  map("n", "gD", vim.lsp.buf.declaration)
  map("n", "gt", telescope_builtin.lsp_type_definitions)
  map("n", "gr", function() telescope_builtin.lsp_references({ include_current_line = true }) end)
  map("n", "gi", telescope_builtin.lsp_implementations)
  map("n", "<leader>a", vim.lsp.buf.code_action)
  map("n", "<leader>s", telescope_builtin.lsp_document_symbols)
  map("n", "<leader>w", telescope_builtin.lsp_workspace_symbols)
  map("n", "<leader>d", telescope_builtin.diagnostics)
  map("n", "K", vim.lsp.buf.hover)
  map("i", "<C-k>", vim.lsp.buf.signature_help)
  map("n", "<leader>r", vim.lsp.buf.rename)
  map("n", "gp", vim.diagnostic.goto_prev)
  map("n", "gn", vim.diagnostic.goto_next)
  map("n", "gl", vim.diagnostic.open_float)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then return M end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
