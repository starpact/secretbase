local navic = require("nvim-navic")
local util = require("lsp.util")

local config = {
  cmd = { "jdt-language-server", "-data", vim.fs.normalize("~/.cache/jdtls/workspace") },
  root_dir = util.get_buf_root_dir({ ".gradlew", ".git", "mvnw" }),
  capabilities = util.capabilities,
  on_attach = function(client, bufnr) navic.attach(client, bufnr) end,
}

require("jdtls").start_or_attach(config)

util.format_on_save({ pattern = { "*.java" } })
