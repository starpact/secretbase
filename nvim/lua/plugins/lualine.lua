local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

local diff = {
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = "#a9b665" },
    modified = { fg = "#7daea3" },
    removed = { fg = "#ea6962" },
  },
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  diagnostics_color = {
    error = { fg = "#ea6962" },
    warn = { fg = "#d8a657" },
  },
}

lualine.setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "NvimTree", "Outline" },
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
