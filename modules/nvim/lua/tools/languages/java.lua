local null_ls = require("null-ls")
local util = require("tools.util")

local M = {}

local function start_or_attach()
  local root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "mvnw" })
  local root_dir_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
  local config = {
    cmd = {
      "jdt-language-server",
      "-data",
      vim.fs.normalize("~/.cache/jdtls/workspace/") .. root_dir_name,
    },
    root_dir = root_dir,
    capabilities = util.capabilities,
    on_attach = util.on_attach,
  }

  require("jdtls").start_or_attach(config)
end

M.setup_lsp = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = start_or_attach,
  })
end

local function find_config()
  if vim.fn.filereadable("google_checks.xml") == 1 then
    return "google_checks.xml"
  end
  return vim.fs.normalize("~/.config/nvim/bundles/google_checks.xml")
end

M.linter = null_ls.builtins.diagnostics.checkstyle.with({
  extra_args = {
    "-c",
    find_config(),
  },
})

return M
