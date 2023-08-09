local fzf = require("fzf-lua")

local no_preview_winopts = {
  preview = {
    hidden = "hidden",
  },
}

vim.keymap.set("n", "<leader>f", fzf.files)
vim.keymap.set("n", "<leader>o", fzf.oldfiles)
vim.keymap.set("n", "<leader>b", fzf.buffers)
vim.keymap.set("n", "<leader>/", function()
  local cwd
  if vim.bo.filetype == "NvimTree" then
    local node = require("nvim-tree.api").tree.get_node_under_cursor()
    if node.type == "file" then
      cwd = node.parent.absolute_path
    elseif node.type == "directory" then
      cwd = node.absolute_path
    end
    vim.cmd("wincmd l") -- avoid open file action from nvim-tree buffer
  else
    cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  end
  fzf.live_grep({ cwd = cwd })
end)
vim.keymap.set("n", "<leader>?", fzf.live_grep)
vim.keymap.set("n", "<leader>d", function()
  fzf.diagnostics_workspace({ severity_only = "error" })
end)
vim.keymap.set("n", "<leader>D", fzf.diagnostics_workspace)
vim.keymap.set("n", "<leader>gs", fzf.git_status)
vim.keymap.set("n", "<leader>gc", fzf.git_bcommits)
vim.keymap.set("n", "<leader>l", fzf.builtin)

fzf.register_ui_select()
fzf.setup({
  winopts = {
    height = 0.8,
    width = 0.6,
    row = 0.5,
    col = 0.5,
    border = "single",
    hl = {
      cursorline = "visual",
    },
    preview = {
      delay = 0,
      layout = "vertical",
      vertical = "down:60%",
    },
  },
  fzf_opts = {
    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
  },
  files = {
    cwd_prompt = false,
    winopts = no_preview_winopts,
    git_icons = false,
  },
  oldfiles = {
    winopts = no_preview_winopts,
  },
  buffers = {
    winopts = no_preview_winopts,
  },
  grep = {
    git_icons = false,
    rg_glob = true,
  },
  lsp = {
    async_or_timeout = 20000,
    jump_to_single_result = true,
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
