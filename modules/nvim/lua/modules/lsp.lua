local lspconfig = require("lspconfig")
local fzf = require("fzf-lua")

local default_config = {
  capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  ),
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gd", fzf.lsp_definitions, opts)
    vim.keymap.set("n", "gD", fzf.lsp_declarations, opts)
    vim.keymap.set("n", "gy", fzf.lsp_typedefs, opts)
    vim.keymap.set("n", "gr", function()
      fzf.lsp_references({ ignore_current_line = true })
    end, opts)
    vim.keymap.set("n", "gi", fzf.lsp_implementations, opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>s", fzf.lsp_document_symbols, opts)
    vim.keymap.set("n", "<leader>S", fzf.lsp_live_workspace_symbols, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader><leader>f", vim.lsp.buf.format, opts)
  end,
}

for _, server in ipairs({
  "bashls",
  "bufls",
  "cssls",
  "eslint",
  "html",
  "jsonls",
  "nil_ls",
  "pyright",
  "taplo",
  "terraformls",
  "tsserver",
  -- "yamlls",
  "zls",
}) do
  lspconfig[server].setup(default_config)
end

local function extend_default(config)
  return vim.tbl_deep_extend("force", default_config, config)
end

lspconfig.clangd.setup(extend_default({
  cmd = { "clangd", "--function-arg-placeholders=0" },
  filetypes = { "c", "cpp" },
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
}))

lspconfig.lua_ls.setup(extend_default({
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = { vim.fn.expand("$VIMRUNTIME/lua") },
      },
    },
  },
}))

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.lsp.start(
      extend_default({
        name = "gopls",
        cmd = { "gopls" },
        root_dir = vim.fs.dirname(vim.fs.find({ "go.mod" }, { upward = true })[1]),
      }),
      {
        reuse_client = function(client, config)
          return client.config.name == config.name
        end,
      }
    )
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.lsp.start(
      extend_default({
        name = "rust_analyzer",
        cmd = { "rust-analyzer" },
        root_dir = vim.fs.dirname(vim.fs.find({ "Cargo.toml" }, { upward = true })[1]),
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            completion = {
              postfix = {
                enable = false,
              },
              callable = {
                snippets = "add_parentheses",
              },
            },
          },
        },
      }),
      {
        reuse_client = function(client, config)
          return client.config.name == config.name
        end,
      }
    )
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "mvnw" })
    local root_dir_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    require("jdtls").start_or_attach(extend_default({
      cmd = {
        "jdt-language-server",
        "-data",
        vim.fs.normalize("~/.cache/jdtls/workspace/") .. root_dir_name,
      },
      root_dir = root_dir,
    }))
  end,
})
