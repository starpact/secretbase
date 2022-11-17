local M = {}

M.path_display = function(path)
  path = string.gsub(path, "src/main/java/", "J/", 1)

  local nix_store = "/nix/store/"
  if vim.startswith(path, nix_store) then
    local str = string.match(path, "/nix/store/[0-9a-z]+")
    return str and "NIX/" .. string.sub(path, #str + 2) or path
  end

  local cwd = vim.fn.getcwd()
  if vim.startswith(path, cwd .. "/") then
    return string.sub(path, #cwd + 2)
  end

  local home = vim.fs.normalize("~/")
  local cargo_src = home .. ".cargo/registry/src/"
  if vim.startswith(path, cargo_src) then
    local str = string.match(path, cargo_src .. "github.com[-0-9a-z]+/")
    return str and "RS/" .. string.sub(path, #str + 1) or path
  end
  local workspace = home .. "workspace/"
  if vim.startswith(path, workspace) then
    return "W/" .. string.sub(path, #workspace + 1)
  end
  if vim.startswith(path, home) then
    return "~/" .. string.sub(path, #home + 1)
  end

  if string.sub(path, 1, 3) == "jdt" then
    return string.sub(path, 16, string.find(path, "?") - 1)
  end

  return path
end

return M
