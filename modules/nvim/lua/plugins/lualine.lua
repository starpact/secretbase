local path_display = function(path)
  path = string.gsub(path, "src/main/java/", "J/", 1)
  path = string.gsub(path, "/NvimTree_1", "", 1)

  local cwd = vim.fn.getcwd()
  if vim.startswith(path, cwd .. "/") then
    return string.sub(path, #cwd - #vim.fs.basename(cwd) + 1)
  end

  local nix_store = "/nix/store/"
  if vim.startswith(path, nix_store) then
    local str = string.match(path, nix_store .. "[0-9a-z]+")
    return str and "NIX/" .. string.sub(path, #str + 2) or path
  end

  local home = vim.fs.normalize("~/")
  if vim.startswith(path, home) then
    return "~/" .. string.sub(path, #home + 1)
  end

  if vim.startswith(path, "jdt") then
    return string.sub(path, 16, string.find(path, "?") - 1)
  end

  return path
end

local function buf_name_display()
  local name = path_display(vim.api.nvim_buf_get_name(0))
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
