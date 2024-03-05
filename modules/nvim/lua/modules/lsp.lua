local lspconfig = require("lspconfig")
local builtin = require("telescope.builtin")

local default_config
do
  default_config = {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider.full = false
      local opts = { buffer = bufnr }
      vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
      vim.keymap.set("n", "gy", builtin.lsp_type_definitions, opts)
      vim.keymap.set("n", "gr", function()
        builtin.lsp_references({ include_declaration = false })
      end, opts)
      vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
      vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>s", function()
        builtin.lsp_document_symbols({ symbol_width = 80 })
      end, opts)
      vim.keymap.set("n", "<leader>S", function()
        builtin.lsp_dynamic_workspace_symbols({ symbol_width = 80 })
      end, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    end,
  }
end

local function extend_default(config)
  return vim.tbl_deep_extend("force", default_config, config)
end

for server, config in pairs({
  ["bashls"] = {},
  ["bufls"] = {},
  ["clangd"] = {
    cmd = { "clangd", "--function-arg-placeholders=0" },
    filetypes = { "c", "cpp" },
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
  },
  ["cssls"] = {},
  ["eslint"] = {},
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
  ["tsserver"] = {},
  ["zls"] = {},
}) do
  lspconfig[server].setup(next(config) == nil and default_config or extend_default(config))
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gotmpl" },
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
  pattern = "java",
  callback = function()
    print("xxxxxxxx")
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
