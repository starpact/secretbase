local lsputil = require("lspconfig").util
local util = require("tools.util")

local M = {}

local function go_organize_imports(timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

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

M.format = function()
  go_organize_imports(1000)
  vim.lsp.buf.format()
end

return M
