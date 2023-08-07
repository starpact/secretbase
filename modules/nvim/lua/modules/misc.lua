require("nvim-autopairs").setup({ check_ts = true })
require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

require("nvim-surround").setup()

require("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

require("leap").set_default_keymaps()

require("harpoon").setup()
vim.keymap.set("n", "<leader>M", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>m", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "gn", require("harpoon.ui").nav_next)
vim.keymap.set("n", "gp", require("harpoon.ui").nav_prev)

do
  local gitsigns = require("gitsigns")
  gitsigns.setup({
    on_attach = function(bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set("n", "<leader>gh", gitsigns.preview_hunk, opts)
      vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, opts)
      vim.keymap.set("n", "[g", gitsigns.prev_hunk, opts)
      vim.keymap.set("n", "]g", gitsigns.next_hunk, opts)
    end,
  })

  require("diffview").setup({
    use_icons = false,
    view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
  })
  vim.keymap.set("n", "<leader>go", "<cmd>DiffviewOpen<CR>")
  vim.keymap.set("n", "<leader>gO", function()
    vim.fn.jobstart({ "git", "show-ref", "-q", "--heads", "main" }, {
      on_exit = function(_, code)
        local default_branch = code == 0 and "main" or "master"
        vim.cmd("DiffviewOpen " .. default_branch)
      end,
    })
  end)
  vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<CR>")
  vim.keymap.set("n", "<leader>gF", "<cmd>DiffviewFileHistory<CR>")
end

-- Set pwd to project root.
vim.keymap.set("n", "<leader>w", function()
  local path = vim.fs.find({
    "build.zig",
    ".git",
    "Cargo.toml",
    "go.mod",
    "gradlew",
    "Makefile",
    "mvnw",
    "package.json",
    "requirements.txt",
  }, {
    path = vim.api.nvim_buf_get_name(0),
    upward = true,
  })[1]
  if path then vim.api.nvim_set_current_dir(vim.fs.dirname(path)) end
end)

do
  -- Toggle diagnostic virtual text.
  local diagnostic_config = {
    severity_sort = true,
    float = {
      source = true,
    },
    virtual_text = true,
  }
  vim.diagnostic.config(diagnostic_config)
  vim.keymap.set("n", "<A-D>", function()
    diagnostic_config.virtual_text = not diagnostic_config.virtual_text
    vim.diagnostic.config(diagnostic_config)
  end)
end

for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = "", texthl = hl })
end

vim.api.nvim_create_autocmd("CursorMoved", { command = "echo" })
