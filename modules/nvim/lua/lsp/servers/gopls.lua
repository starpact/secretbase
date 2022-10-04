local util = require("lsp.util")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    vim.lsp.start(
      {
        name = "gopls",
        cmd = { "gopls" },
        root_dir = util.get_buf_root_dir({ ".git", "go.mod" }),
        capabilities = util.capabilities,
      },
      { reuse_client = util.should_reuse_client_func({ "/nix", "~/go" }) })
  end,
})

local function go_organize_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
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

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.go" },
  callback = function()
    go_organize_imports(1000)
    vim.lsp.buf.format({ timeout_ms = 500 })
  end,
})
