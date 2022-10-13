local navic = require("nvim-navic")

require("lualine").setup({
  options = {
    disabled_filetypes = { winbar = { "toggleterm", "NvimTree" } },
  },

  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      { "diff", symbols = { added = " ", modified = " ", removed = " " } },
    },
    lualine_c = { { "diagnostics", sections = { "error", "warn", "info" } } },
    lualine_x = { "filetype" },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {
    lualine_c = {
      { "filename", path = 1, color = { bg = "None", gui = "bold" } },
      { navic.get_location, cond = navic.is_available },
    },
  },
  inactive_winbar = {
    lualine_c = {
      { "filename", path = 1, color = { bg = "None" } },
    }
  },
})
