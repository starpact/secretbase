local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " },
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

lualine.setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "NvimTree", "Outline" },
  },
  sections = {
    lualine_a = { "branch", diff },
    lualine_b = { diagnostics },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "encoding", "filetype" },
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
