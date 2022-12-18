local util = require("plugins.util")

local function buf_name_display()
  local name = util.path_display(vim.api.nvim_buf_get_name(0))
  if name == "" then
    return ""
  end
  if not vim.bo.modifiable or vim.bo.readonly then
    return name .. " [-]"
  elseif vim.bo.modified then
    return name .. " [+]"
  end
  return name
end

require("lualine").setup({
  options = {
    section_separators = "",
    component_separators = "│",
    globalstatus = true,
  },
  sections = {
    lualine_a = { buf_name_display },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
    },
    lualine_x = { "filetype" },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
})
