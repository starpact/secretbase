local fzf = require("fzf-lua")

local function no_hl_cursorline(command)
  return function()
    command({ winopts = { hl = { cursorline = "" } } })
  end
end

vim.keymap.set("n", "<leader>f", no_hl_cursorline(fzf.files))
vim.keymap.set("n", "<leader>o", no_hl_cursorline(fzf.oldfiles))
vim.keymap.set("n", "<leader>b", no_hl_cursorline(fzf.buffers))
vim.keymap.set("n", "<leader>/", fzf.live_grep)
vim.keymap.set("n", "<leader>?", fzf.grep_cword)
vim.keymap.set("n", "<leader>d", fzf.diagnostics_workspace)
vim.keymap.set("n", "<leader>q", fzf.quickfix)
vim.keymap.set("n", "<leader>l", fzf.builtin)

require("fzf-lua").setup({
  winopts = {
    hl = { cursorline = "visual" },
    preview = { layout = "vertical", delay = 0, vertical = "down:50%" },
  },
  fzf_opts = {
    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
    ["--no-separator"] = "",
  },
  git = {
    status = { preview_pager = "delta" },
    commits = { preview_pager = "delta" },
    bcommits = { preview_pager = "delta" },
  },
  keymap = {
    fzf = {
      ["ctrl-n"] = "down",
      ["ctrl-p"] = "up",
      ["ctrl-j"] = "next-history",
      ["ctrl-k"] = "previous-history",
    },
  },
})
