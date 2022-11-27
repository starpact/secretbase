local lsputil = require("lspconfig").util
local util = require("tools.util")

local M = {}

local function start_or_attach()
  vim.lsp.start({
    name = "gopls",
    cmd = { "gopls" },
    root_dir = lsputil.root_pattern(".git", "go.mod")(vim.api.nvim_buf_get_name(0)),
    capabilities = util.capabilities,
    on_attach = util.on_attach,
  }, {
    reuse_client = util.reuse_client("/nix", "~/go"),
  })
end

M.setup_lsp = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "gomod", "gowork", "gotmpl" },
    callback = start_or_attach,
  })
end

M.update_dap = function(dap)
  dap.adapters.delve = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }
  dap.configurations.go = {
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "delve",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }
end

return M
