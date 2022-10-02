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

local util = require("lsp.util")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust" },
  callback = function()
    vim.lsp.start(
      {
        name = "rust-analyzer",
        cmd = { "rust-analyzer" },
        root_dir = util.get_root_dir({ "Cargo.toml" }),
        capabilities = util.capabilities,
        settings = settings,
      },
      {
        reuse_client = function(client, config)
          return client.name == config.name and util.buf_starts_with_any({ "/nix", "~/.cargo" })
        end
      })
  end,
})

util.format_on_save({ pattern = { "*.rs" } })
