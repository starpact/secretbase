local lspconfig = require("lspconfig")
local fzf = require("fzf-lua")

local default_config = {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", function()
      fzf.lsp_references({ includeDeclaration = false })
    end, opts)
    vim.keymap.set("n", "gi", fzf.lsp_implementations, opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>s", fzf.lsp_document_symbols, opts)
    vim.keymap.set("n", "<leader>S", fzf.lsp_live_workspace_symbols, opts)
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
  end,
}

local function extend_default(config)
  if next(config) == nil then return default_config end
  return vim.tbl_deep_extend("force", default_config, config)
end

for server, config in pairs({
  ["bashls"] = {},
  ["bufls"] = {},
  ["clangd"] = {
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
  },
  ["cssls"] = {},
  ["eslint"] = {},
  ["gopls"] = {},
  ["html"] = {},
  ["jsonls"] = {},
  ["lua_ls"] = {
    settings = {
      Lua = {
        workspace = {
          library = { vim.fn.expand("$VIMRUNTIME/lua") },
        },
      },
    },
  },
  ["nil_ls"] = {},
  ["pyright"] = {},
  ["rust_analyzer"] = {
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy",
        },
      },
    },
  },
  ["taplo"] = {},
  ["vtsls"] = {},
  ["zls"] = {},
}) do
  lspconfig[server].setup(extend_default(config))
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "mvnw" })
    local root_dir_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    require("jdtls").start_or_attach(extend_default({
      cmd = {
        "jdtls",
        "-data",
        vim.fs.normalize("~/.cache/jdtls/workspace/") .. root_dir_name,
      },
      root_dir = root_dir,
    }))
  end,
})
