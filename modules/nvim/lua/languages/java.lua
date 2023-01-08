local default = require("languages.default")

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
    capabilities = default.capabilities,
    on_attach = default.on_attach,
  }

  require("jdtls").start_or_attach(config)
end

M.setup_lsp = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = start_or_attach,
  })
end

local function checkstyle_config_path()
  for _, path in ipairs({ "checkstyle.xml", "scripts/google_style_check.xml" }) do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end

  return "google_checks.xml"
end

M.update_linter = function(linters)
  linters.checkstyle.args = {
    "-c",
    checkstyle_config_path,
  }
end

return M
