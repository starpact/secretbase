local navic = require("nvim-navic")
local util = require("lsp.util")

local root_dir = require('jdtls.setup').find_root({ ".git", "gradlew", "mvnw" })
local root_dir_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local config = {
  cmd = {
    "jdt-language-server",
    "-data", vim.fs.normalize("~/.cache/jdtls/workspace/") .. root_dir_name,
  },
  root_dir = root_dir,
  capabilities = util.capabilities,
  on_attach = function(client, bufnr) navic.attach(client, bufnr) end,
}

require("jdtls").start_or_attach(config)

util.format_on_save({ pattern = { "*.java" } })
