local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then return end

autopairs.setup({
  check_ts = true,
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp
ok, cmp = pcall(require, "cmp")
if not ok then return end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
