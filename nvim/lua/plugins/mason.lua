require("mason").setup()

local mason_tools = {
  -- language servers
  "bash-language-server",
  "clangd",
  "css-lsp",
  "eslint-lsp",
  "gopls",
  "html-lsp",
  "json-lsp",
  "pyright",
  "rust-analyzer",
  "lua-language-server",
  "taplo",
  "typescript-language-server",
  "yaml-language-server",

  -- linters
  "codespell",
  "flake8",

  --formatters
  "prettier",
  "black",
}

require("mason-tool-installer").setup({
  ensure_installed = mason_tools,
})
