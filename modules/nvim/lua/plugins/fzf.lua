local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader>f", fzf.files)
vim.keymap.set("n", "<leader>o", fzf.oldfiles)
vim.keymap.set("n", "<leader>b", fzf.buffers)
vim.keymap.set("n", "<leader>/", fzf.live_grep)
vim.keymap.set("n", "<leader>?", fzf.grep_cword)
vim.keymap.set("n", "<leader>d", fzf.diagnostics_workspace)
vim.keymap.set("n", "<leader>q", fzf.quickfix)
vim.keymap.set("n", "<leader>F", fzf.builtin)

require("fzf-lua").setup({
  winopts = {
    height = 0.3,
    width = 1,
    row = 1,
    col = 0,
    border = false,
    preview = { default = "bat", delay = 0, horizontal = "right:50%" },
  },
  fzf_opts = { ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history" },
  keymap = {
    fzf = {
      ["ctrl-n"] = "down",
      ["ctrl-p"] = "up",
      ["ctrl-j"] = "next-history",
      ["ctrl-k"] = "previous-history",
    },
  },
})
