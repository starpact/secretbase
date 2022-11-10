local util = require("lsp.util")
local navic = require("nvim-navic")

local name = "rust-analyzer"
local settings = {
  ["rust-analyzer"] = {
    imports = {
      granularity = {
        group = "crate",
        enforce = true,
      },
    },
    checkOnSave = {
      command = "clippy",
    },
    completion = {
      callable = {
        snippets = "add_parentheses",
      },
      postfix = {
        enable = false,
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
local config = {
  name = name,
  cmd = { name },
  root_dir = util.get_buf_root_dir("Cargo.toml"),
  capabilities = util.capabilities,
  on_attach = function(client, bufnr) navic.attach(client, bufnr) end,
  settings = settings,
}
local reuse_patterns = { "/nix", "~/.cargo" }

vim.lsp.start(config, { reuse_client = util.should_reuse_client_func(reuse_patterns) })

util.format_on_save({ pattern = { "*.rs" } })
