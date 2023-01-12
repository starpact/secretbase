local function get_filepath()
  local path = vim.api.nvim_buf_get_name(0)

  path = string.gsub(path, "src/main/java/", "J/", 1)
  path = string.gsub(path, "/NvimTree_1", "", 1)

  local cwd = vim.fn.getcwd()
  if vim.startswith(path, cwd .. "/") then
    return string.sub(path, #cwd - #vim.fs.basename(cwd) + 1)
  end

  local nix_store = "/nix/store/"
  if vim.startswith(path, nix_store) then
    return "NIX/" .. string.sub(path, 45)
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

local function get_git_status()
  local dict = vim.b.gitsigns_status_dict
  if not dict then
    return ""
  end

  local status = dict.head
  if dict.added and dict.added > 0 then
    status = status .. " +" .. dict.added
  end
  if dict.changed and dict.changed > 0 then
    status = status .. " ~" .. dict.changed
  end
  if dict.removed and dict.removed > 0 then
    status = status .. " -" .. dict.removed
  end

  return status
end

local function get_diagnostics()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "i" or mode == "ic" then
    return ""
  end

  local cnts = {}
  for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
    cnts[diagnostic.severity] = (cnts[diagnostic.severity] or 0) + 1
  end
  if #cnts == 0 then
    return ""
  end

  local severity = vim.diagnostic.severity
  return
    (cnts[severity.ERROR] and "%#ErrorFloat#" .. cnts[severity.ERROR] .. " " or "")
      .. (cnts[severity.WARN] and "%#WarningFloat#" .. cnts[severity.WARN] .. " " or "")
      .. (cnts[severity.INFO] and "%#InfoFloat#" .. cnts[severity.INFO] .. " " or "")
      .. (cnts[severity.HINT] and "%#HintFloat#" .. cnts[severity.HINT] .. " " or "")
      .. "%#Statusline#"
end

local function get_filetype()
  return vim.bo.filetype
end

_G.Statusline = function()
  local left = " %-20.(" .. get_git_status() .. " " .. get_diagnostics() .. "%)"
  local center = get_filepath() .. " %m%r"
  local right = "%20.(%l:%c   " .. get_filetype() .. "%)%  "
  return left .. "%=" .. center .. "%=" .. right
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    vim.opt.statusline = "%!v:lua.Statusline()"
  end,
})
