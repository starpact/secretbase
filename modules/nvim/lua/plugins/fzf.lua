local fzf = require("fzf-lua")

local default_winopts = {
  height = 0.3,
  width = 1,
  row = 1,
  col = 0,
  hl = { cursorline = "visual" },
  border = { "─", "─", "─", "", "", "", "", "" },
  preview = { delay = 0, horizontal = "right:50%" },
}
local no_preview_winopts = {
  hl = { cursorline = "" },
  preview = { hidden = "hidden" },
}
local git_opt = {
  winopts = {
    fullscreen = true,
    preview = { horizontal = "up:70%" },
  },
  preview_pager = "delta -s --width=$FZF_PREVIEW_COLUMNS",
}

vim.keymap.set("n", "<leader>f", fzf.files)
vim.keymap.set("n", "<leader>o", fzf.oldfiles)
vim.keymap.set("n", "<leader>b", fzf.buffers)
vim.keymap.set("n", "<leader>/", fzf.live_grep)
vim.keymap.set("n", "<leader>?", fzf.grep_cword)
vim.keymap.set("n", "<leader>d", fzf.diagnostics_workspace)
vim.keymap.set("n", "<leader>gs", fzf.git_status)
vim.keymap.set("n", "<leader>gc", fzf.git_bcommits)
vim.keymap.set("n", "<leader>l", function()
  fzf.builtin({ winopts = default_winopts })
end)

fzf.register_ui_select()
fzf.setup({
  winopts = default_winopts,
  fzf_opts = {
    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
    ["--no-separator"] = "",
  },
  files = { winopts = no_preview_winopts, git_icons = false },
  oldfiles = { winopts = no_preview_winopts },
  buffers = { winopts = no_preview_winopts },
  grep = { git_icons = false },
  git = { status = git_opt, commits = git_opt, bcommits = git_opt },
  lsp = { async_or_timeout = 10000 },
  keymap = {
    fzf = {
      ["ctrl-n"] = "down",
      ["ctrl-p"] = "up",
      ["ctrl-j"] = "next-history",
      ["ctrl-k"] = "previous-history",
    },
  },
})
