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

M.on_attach = function(_, bufnr)
  local function map(mode, keys, cmd)
    vim.api.nvim_buf_set_keymap(bufnr, mode, keys, cmd, { noremap = true, silent = true })
  end

  map("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
  map("n", "gD", "<cmd>lua require('telescope.builtin').lsp_declarations()<CR>")
  map("n", "gt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>")
  map("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references({include_current_line=true})<CR>")
  map("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")
  map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("n", "<leader>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
  map("n", "<leader>w", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>")
  map("n", "<leader>d", "<cmd>lua require('telescope.builtin').diagnostics()<CR>")
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  map("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then return M end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
