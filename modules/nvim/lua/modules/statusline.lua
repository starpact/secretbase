local function get_filepath()
  local path = vim.api.nvim_buf_get_name(0)

  -- Shorten jdt url.
  if vim.startswith(path, "jdt") then
    path = path:sub(16, path:find("?") - 1)
  end

  local basename = vim.fs.basename(path)

  -- Show absolute path in nvim tree.
  if basename == "NvimTree_1" then
    return path:sub(1, #path - 11)
  end

  -- Highlight basename.
  path = path:sub(1, #path - #basename) .. "%#NormalFloat#" .. basename .. "%#Statusline#"

  -- Path starts from current dir.
  local cwd = vim.fn.getcwd()
  if vim.startswith(path, cwd .. "/") then
    return path:sub(#cwd - #vim.fs.basename(cwd) + 1)
  end

  -- Shorten nix path.
  local nix_store = "/nix/store/"
  if vim.startswith(path, nix_store) then
    return "NIX/" .. path:sub(45)
  end

  -- Shorten home path.
  local home = vim.fs.normalize("~/")
  if vim.startswith(path, home) then
    return "~/" .. path:sub(#home + 1)
  end

  return path
end

local function get_git_status()
  local dict = vim.b.gitsigns_status_dict
  if not dict then
    return ""
  end
  return dict.head
    .. (dict.added and dict.added > 0 and " +" .. dict.added or "")
    .. (dict.changed and dict.changed > 0 and " ~" .. dict.changed or "")
    .. (dict.removed and dict.removed > 0 and " -" .. dict.removed or "")
end

local function get_diagnostics()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "i" or mode == "ic" or mode == "s" then
    return ""
  end

  local cnts = {}
  for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
    cnts[diagnostic.severity] = (cnts[diagnostic.severity] or 0) + 1
  end
  if next(cnts) == nil then
    return ""
  end

  local severity = vim.diagnostic.severity
  return (cnts[severity.ERROR] and "%#ErrorFloat#" .. cnts[severity.ERROR] .. " " or "")
    .. (cnts[severity.WARN] and "%#WarningFloat#" .. cnts[severity.WARN] .. " " or "")
    .. (cnts[severity.INFO] and "%#InfoFloat#" .. cnts[severity.INFO] .. " " or "")
    .. (cnts[severity.HINT] and "%#HintFloat#" .. cnts[severity.HINT] .. " " or "")
    .. "%#Statusline#"
end

_G.Statusline = function()
  local left = get_filepath() .. " %m%r  " .. get_diagnostics()
  local right = get_git_status() .. "%10.(%l,%c%)"
  return left .. "%=" .. right
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    vim.opt.statusline = "%!v:lua.Statusline()"
  end,
})
