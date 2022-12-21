local fzf = require("fzf-lua")

local function with_opt(opt)
  return function(command)
    return function()
      command(opt)
    end
  end
end

local opt_no_preview = {
  winopts = {
    hl = { cursorline = "" },
    preview = { hidden = "hidden" },
  },
}
local opt_fullscreen = { winopts = { fullscreen = true } }

vim.keymap.set("n", "<leader>f", with_opt(opt_no_preview)(fzf.files))
vim.keymap.set("n", "<leader>o", with_opt(opt_no_preview)(fzf.oldfiles))
vim.keymap.set("n", "<leader>b", with_opt(opt_no_preview)(fzf.buffers))
vim.keymap.set("n", "<leader>/", fzf.live_grep)
vim.keymap.set("n", "<leader>?", fzf.grep_cword)
vim.keymap.set("n", "<leader>d", fzf.diagnostics_workspace)
vim.keymap.set("n", "<leader>gs", with_opt(opt_fullscreen)(fzf.git_status))
vim.keymap.set("n", "<leader>gc", with_opt(opt_fullscreen)(fzf.git_bcommits))
vim.keymap.set("n", "<leader>l", function()
  fzf.builtin({ winopts = { height = 0.3, width = 1, row = 1, col = 0 } })
end)

fzf.setup({
  winopts = {
    height = 0.3,
    width = 1,
    row = 1,
    col = 0,
    hl = { cursorline = "visual" },
    border = { "─", "─", "─", "", "", "", "", "" },
    preview = { delay = 0, horizontal = "right:50%" },
  },
  fzf_opts = {
    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
    ["--no-separator"] = "",
  },
  files = { git_icons = false },
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
