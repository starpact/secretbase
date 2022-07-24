local diff = {
  "diff",
  symbols = {
    added = " ",
    modified = " ",
    removed = " ",
  },
}

local diagnostics = {
  "diagnostics",
  sections = { "error", "warn", "info" },
  diagnostics_color = {
    error = { fg = "#ea6962" },
    warn = { fg = "#d8a657" },
    info = { fg = "#7daea3" },
  },
}

require("lualine").setup({
  options = {
    disabled_filetypes = { "NvimTree" },
  },
  sections = {
    lualine_a = { { "filename", path = 1 } },
    lualine_b = { "branch", diff },
    lualine_c = { diagnostics },
    lualine_x = { "filetype" },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
