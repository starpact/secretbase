local servers = {
  "bashls",
  "cssls",
  "clangd",
  "eslint",
  "html",
  "jsonls",
  "pyright",
  "rnix",
  "sumneko_lua",
  "taplo",
  "tsserver",
  "yamlls",
}

for _, server in ipairs(servers) do
  local configured, config = pcall(require, "lsp.servers." .. server)
  if configured then
    config.capabilities = require("lsp.util").capabilities
    require("lspconfig")[server].setup(config)
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local telescope = require("telescope.builtin")
    local function map(mode, key, cmd, opts)
      opts = opts or {}
      opts.buffer = args.bufnr
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
})

require("lsp.servers.gopls")
require("lsp.servers.rust_analyzer")
