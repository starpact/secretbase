local gitsigns = require("gitsigns")
gitsigns.setup({
  on_attach = function(bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "<leader>gh", gitsigns.preview_hunk, opts)
    vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, opts)
    vim.keymap.set("n", "[g", gitsigns.prev_hunk, opts)
    vim.keymap.set("n", "]g", gitsigns.next_hunk, opts)
  end,
})

require("diffview").setup({
  use_icons = false,
})
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory %<CR>")
