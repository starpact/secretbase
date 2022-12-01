local util = require("plugins.util")

local function buf_name_display()
  local name = util.path_display(vim.api.nvim_buf_get_name(0))
  if name == "" then
    return ""
  end
  local status = ""
  if not vim.bo.modifiable or vim.bo.readonly then
    status = " [-]"
  elseif vim.bo.modified then
    status = " [+]"
  end
  return name .. status
end

require("lualine").setup({
  options = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = { "TelescopePrompt" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { buf_name_display },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
    },
    lualine_x = { "searchcount", "filetype" },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
})
