local fzf = require("fzf-lua")

local M = {}

M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

function M.on_attach(_, bufnr)
  vim.keymap.set("n", "gd", fzf.lsp_definitions, { buffer = bufnr })
  vim.keymap.set("n", "gD", fzf.lsp_declarations, { buffer = bufnr })
  vim.keymap.set("n", "gy", fzf.lsp_typedefs, { buffer = bufnr })
  vim.keymap.set("n", "gr", function()
    fzf.lsp_references({ ignore_current_line = true })
  end, { buffer = bufnr })
  vim.keymap.set("n", "gi", fzf.lsp_implementations, { buffer = bufnr })
  vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
  vim.keymap.set("n", "<leader>s", fzf.lsp_document_symbols, { buffer = bufnr })
  vim.keymap.set("n", "<leader>S", fzf.lsp_live_workspace_symbols, { buffer = bufnr })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set("n", "<leader><leader>f", vim.lsp.buf.format, { buffer = bufnr })
end

return M
