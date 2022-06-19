local servers = {
  "bashls",
  "clangd",
  "cssls",
  "eslint",
  "gopls",
  "html",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "taplo",
  "tsserver",
  "yamlls",
}

require("nvim-lsp-installer").setup({
  ensure_installed = { "bashls", "jsonls", "pyright", "yamlls" },
})

local lspconfig = require("lspconfig")
for _, server in ipairs(servers) do
  local configured, config = pcall(require, "lsp.servers." .. server)
  if configured then
    lspconfig[server].setup(
      vim.tbl_deep_extend("keep", config, require("lsp.default"))
    )
  end
end

-- UI
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  severity_sort = true,
  float = { source = "always" },
})
