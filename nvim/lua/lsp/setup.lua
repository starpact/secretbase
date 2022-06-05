require("nvim-lsp-installer").setup()

local servers = {
  "cssls",
  "clangd",
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

local lspconfig = require("lspconfig")
for _, server in ipairs(servers) do
  local configured, settings = pcall(require, "lsp.settings." .. server)
  if configured then
    lspconfig[server].setup(
      vim.tbl_deep_extend("keep", settings, require("lsp.handlers"))
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
