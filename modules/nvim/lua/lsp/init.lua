local navic = require("nvim-navic")

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
    config.on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end
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
    map("n", "gy", telescope.lsp_type_definitions)
    map("n", "gr", function() telescope.lsp_references({ include_current_line = false }) end)
    map("n", "gi", telescope.lsp_implementations)
    map("n", "<leader>a", vim.lsp.buf.code_action)
    map("n", "<leader>s", telescope.lsp_document_symbols)
    map("n", "<leader>S", telescope.lsp_dynamic_workspace_symbols)
    map("n", "K", vim.lsp.buf.hover)
    map("i", "<C-k>", vim.lsp.buf.signature_help)
    map("n", "<leader>r", vim.lsp.buf.rename)
  end
})
