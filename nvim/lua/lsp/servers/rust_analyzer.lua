local util = require("lsp.util")

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust" },
  callback = function()
    vim.lsp.start(
      {
        name = name,
        cmd = { name },
        root_dir = util.get_buf_root_dir("Cargo.toml"),
        capabilities = util.capabilities,
        settings = settings,
      },
      { reuse_client = util.should_reuse_client_func({ "/nix", "~/.cargo" }) }
    )
  end,
})

util.format_on_save({ pattern = { "*.rs" } })
