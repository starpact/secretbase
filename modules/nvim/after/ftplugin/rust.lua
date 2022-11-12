-- local util = require("lsp.util")
-- local navic = require("nvim-navic")
--
-- local settings = {
--   ["rust-analyzer"] = {
--     checkOnSave = {
--       command = "clippy",
--     },
--     completion = {
--       callable = {
--         snippets = "add_parentheses",
--       },
--     },
--     workspace = {
--       symbol = {
--         search = {
--           kind = "all_symbols",
--         },
--       },
--     },
--   },
-- }
-- local config = {
--   name = "rust-analyzer",
--   cmd = { "rust-analyzer" },
--   root_dir = util.get_buf_root_dir("Cargo.toml"),
--   capabilities = util.capabilities,
--   on_attach = function(client, bufnr) navic.attach(client, bufnr) end,
--   settings = settings,
-- }
-- local reuse_client = util.should_reuse_client_func({ "/nix", "~/.cargo" })
--
-- vim.lsp.start(config, { reuse_client = reuse_client })
-- util.format_on_save({ pattern = { "*.rs" } })
