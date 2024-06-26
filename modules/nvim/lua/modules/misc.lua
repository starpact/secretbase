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
    type = "file",
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
    virtual_text = false,
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

require("nvim-surround").setup()

require("nvim-autopairs").setup({ check_ts = true })

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

  require("diffview").setup({ use_icons = false })
  vim.cmd("cnoreabbrev D DiffviewOpen")
  vim.keymap.set("n", "<leader>gf", function()
    vim.cmd.DiffviewFileHistory("%")
  end)
  vim.keymap.set("n", "<leader>gF", vim.cmd.DiffviewFileHistory)
end
