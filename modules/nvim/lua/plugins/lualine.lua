local navic = require("nvim-navic")

local function get_workspace_name()
  local cwd = vim.fn.getcwd()
  local index = string.find(cwd, "/[^/]*$") or 0
  return string.sub(cwd, index + 1)
end

local function get_relative_filepath()
  local filepath = vim.fn.expand("%:~:.")
  if string.sub(filepath, 1, 3) == "jdt" then
    return string.sub(filepath, 16, string.find(filepath, "?") - 1)
  end
  return filepath
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
    lualine_a = { get_workspace_name },
    lualine_b = { "branch", { "diff", symbols = { added = " ", modified = " ", removed = " " } } },
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
      { get_relative_filepath, max_length = 0, color = { bg = "None", gui = "bold" } },
      { navic.get_location, cond = navic.is_available },
    },
  },
  inactive_winbar = {
    lualine_c = {
      { get_relative_filepath, color = { bg = "None" } },
    },
  },
})
