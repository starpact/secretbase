local M = {}

M.setup = function()
  local signs = { Error = "", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  vim.diagnostic.config({
    virtual_text = { prefix = "" },
    underline = false,
    severity_sort = true,
    float = { source = "always" },
  })
end

M.on_attach = function(_, bufnr)
  local map = function(mode, keys, cmd)
    vim.api.nvim_buf_set_keymap(bufnr, mode, keys, cmd, { noremap = true, silent = true })
  end

  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("n", "gp", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
  map("n", "gn", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
  map("n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>")
  map("n", "gl", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

  vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 300)")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
