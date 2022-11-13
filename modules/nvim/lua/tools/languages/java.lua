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

function M.setup_lsp()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = start_or_attach,
  })
end

return M
