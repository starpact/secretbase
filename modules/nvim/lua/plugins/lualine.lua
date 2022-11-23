local navic = require("nvim-navic")
local util = require("plugins.util")

navic.setup({ highlight = true })

local function workspace_name()
  local cwd = vim.fn.getcwd()
  local index = string.find(cwd, "/[^/]*$") or 0
  return string.sub(cwd, index + 1)
end

local function buf_name_display()
  return util.path_display(vim.api.nvim_buf_get_name(0))
end

require("lualine").setup({
  options = {
    disabled_filetypes = {
      "NvimTree",
      winbar = { "toggleterm" },
    },
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },

  sections = {
    lualine_a = { workspace_name },
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
      buf_name_display,
      { navic.get_location, cond = navic.is_available },
    },
  },
  inactive_winbar = {
    lualine_c = { buf_name_display },
  },
})
