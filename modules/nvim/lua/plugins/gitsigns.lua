local gitsigns = require("gitsigns")

gitsigns.setup({
  on_attach = function(bufnr)
    local function map(mode, key, cmd, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, key, cmd, opts)
    end

    map("n", "<leader>gh", gitsigns.preview_hunk)
    map("n", "<leader>gb", gitsigns.toggle_current_line_blame)
    map("n", "<leader>gd", gitsigns.diffthis)
    map("n", "[g", gitsigns.prev_hunk)
    map("n", "]g", gitsigns.next_hunk)
  end,
})
