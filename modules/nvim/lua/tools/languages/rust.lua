local lsputil = require("lspconfig").util
local util = require("tools.util")

local M = {}

local settings = {
  ["rust-analyzer"] = {
    checkOnSave = {
      command = "clippy",
    },
    completion = {
      callable = {
        snippets = "add_parentheses",
      },
    },
    workspace = {
      symbol = {
        search = {
          kind = "all_symbols",
        },
      },
    },
  },
}

local function start_or_attach()
  vim.lsp.start({
    name = "rust-analyzer",
    cmd = { "rust-analyzer" },
    root_dir = lsputil.root_pattern("Cargo.toml")(vim.api.nvim_buf_get_name(0)),
    capabilities = util.capabilities,
    on_attach = util.on_attach,
    settings = settings,
  }, {
    reuse_client = util.reuse_client("/nix", "~/.cargo"),
  })
end

M.setup_lsp = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = start_or_attach,
  })
end

return M
