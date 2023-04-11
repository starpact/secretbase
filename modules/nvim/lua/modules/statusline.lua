local function is_current_buf(bufnr)
  return bufnr == vim.api.nvim_buf_get_number(0)
end

local function get_filepath(bufnr)
  local filepath = (function()
    local path = vim.api.nvim_buf_get_name(bufnr)

    -- Shorten jdt url.
    if vim.startswith(path, "jdt") then
      path = path:sub(16, path:find("?") - 1)
    end

    -- Show absolute path in nvim tree.
    if vim.fs.basename(path) == "NvimTree_1" then
      return ""
    end

    -- Path starts from current dir.
    local cwd = vim.fn.getcwd()
    if vim.startswith(path, cwd .. "/") then
      return vim.fs.basename(cwd) .. path:sub(#cwd + 1)
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
  end)()

  return filepath == "" and filepath or filepath .. " %m%r"
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

local function get_diagnostics(bufnr)
  local mode = vim.api.nvim_get_mode().mode
  if mode == "i" or mode == "ic" or mode == "s" then
    return ""
  end

  local cnts = {}
  for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
    cnts[diagnostic.severity] = (cnts[diagnostic.severity] or 0) + 1
  end
  if next(cnts) == nil then
    return ""
  end

  local diagnostics = ""
  for severity, color in pairs({
    [vim.diagnostic.severity.ERROR] = "%#StatusLineError#",
    [vim.diagnostic.severity.WARN] = "%#StatusLineWarn#",
    [vim.diagnostic.severity.INFO] = "%#StatusLineInfo#",
    [vim.diagnostic.severity.HINT] = "%#StatusLineHint#",
  }) do
    if cnts[severity] then
      diagnostics = diagnostics .. " " .. color .. cnts[severity]
    end
  end
  if diagnostics == "" then
    return ""
  end

  return diagnostics .. (is_current_buf(bufnr) and "%#Statusline#" or "%#StatuslineNC#")
end

_G.Statusline = function(bufnr)
  local left = get_filepath(bufnr) .. get_diagnostics(bufnr)
  local right = (is_current_buf(bufnr) and get_git_status() or "") .. "%8.(%l,%c%)"
  return left .. "%=" .. right
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function(opt)
    vim.opt_local.statusline = string.format("%%!v:lua.Statusline(%d)", opt.buf)
  end,
})
