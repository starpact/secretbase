local dressing = require("dressing")

local themes = require("telescope.themes")
local telescope = themes.get_cursor({ initial_mode = "normal" })

dressing.setup({
  select = {
    telescope = telescope
  },
})
